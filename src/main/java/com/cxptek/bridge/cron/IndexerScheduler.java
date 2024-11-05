package com.cxptek.bridge.cron;

import com.cxptek.bridge.entity.Chain;
import com.cxptek.bridge.entity.CronJobHistory;
import com.cxptek.bridge.service.AbstractIndexer;
import com.cxptek.bridge.service.IndexerResolver;
import com.cxptek.bridge.service.chain.ChainService;
import com.cxptek.bridge.service.cronjob.CronJobService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.math.BigInteger;
import java.util.Date;
import java.util.Objects;

import static com.cxptek.bridge.exception.IndexerServiceException.chainNotExists;
import static com.cxptek.bridge.exception.IndexerServiceException.unsupportedPlatform;

@Slf4j
@Component
@RequiredArgsConstructor
public class IndexerScheduler {

    private final IndexerResolver indexerResolver;
    private final CronJobService cronJobService;
    private final ChainService chainService;

    public void run(Long jobId, BigInteger chainId, BigInteger blockWindow) throws Exception {
        log.info("START===indexerScheduler===at:{},chain:{},blockWindow:{}", new Date(), chainId, blockWindow);

        Chain chain = chainService.findById(chainId).orElseThrow(() -> chainNotExists(chainId));

        CronJobHistory jobHistory = CronJobHistory.of(jobId);
        cronJobService.saveHistory(jobHistory);

        AbstractIndexer indexer = indexerResolver.resolve(chain);
        if (Objects.isNull(indexer)) {
            throw unsupportedPlatform(chain.getId(), chain.getPlatform().name());
        }

        var result = indexer.doIndexing(jobHistory, chain, blockWindow);

        jobHistory.setRecordsToProcess(result.getTotal());
        jobHistory.setRecordsSuccessful(result.getProcessed());
        jobHistory.setRecordsWithError(result.getFailed());
        jobHistory.setEndTime(new Date());
        jobHistory.calculateElapsedTime();
        cronJobService.saveHistory(jobHistory);

        log.info("END===indexerScheduler===at:{},chain:{},blockWindow:{}", new Date(), chainId, blockWindow);
    }
}
