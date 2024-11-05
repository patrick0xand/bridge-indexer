package com.cxptek.bridge.model.properties;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.Map;

import static com.cxptek.bridge.utils.Constants.SYSTEM;

@Data
@Slf4j
@Configuration
@ConfigurationProperties(prefix = "indexer")
public class IndexerProperties {
    private Map<String, AccountProperties> accounts;

    public AccountProperties getSystemAccount() {
        return accounts.get(SYSTEM);
    }
}
