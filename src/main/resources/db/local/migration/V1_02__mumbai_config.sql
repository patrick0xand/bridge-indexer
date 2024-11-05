INSERT INTO indexed
    (chain_id, last_processed_block, created_at, created_by)
VALUES
    (80001::bigint, 44088061::bigint, current_timestamp, 'indexer');


INSERT INTO contracts
    (address, chain_id, name, version, is_active, created_by, created_at, abi)
VALUES
    ('0xcb85C84C36C504eE2dC29703E1d4A3bef61eD8A4', 80001::bigint, 'Bridge Core', 1, true, 'indexer', current_timestamp, '[]'),
    ('0x47B400bff10f59EcFF61C590BAeeb62ABF252369', 80001::bigint, 'Bridge Registry', 1, true, 'indexer', current_timestamp, '[]'),
    ('0xbfb13B205c86e6cb7965C4344D466Dc9133e7116', 80001::bigint, 'Token Transfer', 1, true, 'indexer', current_timestamp, '[]'),
    ('0x25D50B8bdE8cd12831be348a18686A923C53d335', 80001::bigint, 'Forwarder', 1, true, 'indexer', current_timestamp, '[]');

--- EVENTS

INSERT INTO events
    (name, chain_id, contract_address, topic, is_active, created_at, created_by)
VALUES
    ('BridgeMessage',   80001.00,      '0xcb85C84C36C504eE2dC29703E1d4A3bef61eD8A4', '0xbf2dddb56dbf8dd5f704a7e228dfdadec1bd4d0a0dfdd40dd453c67cfc4203c2', true, current_timestamp, 'indexer'),
    ('TokenUpdate',     80001.00,      '0x47B400bff10f59EcFF61C590BAeeb62ABF252369', '0x91727cba2d28e0b1ef9ac35db61f707d0ce9b18f094cf55006c00cd04fa473bf', true, current_timestamp, 'indexer'),
    ('TokenEnable',     80001.00,      '0x47B400bff10f59EcFF61C590BAeeb62ABF252369', '0xb3f82610f75fe4e2eafd8653b80b1de6ad1a7d00ecefabf909c3c0e7e74ee6d1', true, current_timestamp, 'indexer'),
    ('TokenDisable',    80001.00,      '0x47B400bff10f59EcFF61C590BAeeb62ABF252369', '0x6e72d60926f318fe6db41705b1a970ef2f81e56920da7a852e91146088a7912b', true, current_timestamp, 'indexer'),
    ('RegisterToken',   80001.00,      '0x47B400bff10f59EcFF61C590BAeeb62ABF252369', '0x202b7569ffce248bc59155deb84d4be223a21f5c209f213984211bbb253e89e0', true, current_timestamp, 'indexer'),
    ('RegisterWrappedToken', 80001.00, '0x47B400bff10f59EcFF61C590BAeeb62ABF252369', '0x123aa379e86e557507657254e11aec6b78d8de142c343d3a515980d6365d3215', true, current_timestamp, 'indexer'),
    ('ClaimToken',      80001.00,      '0xbfb13B205c86e6cb7965C4344D466Dc9133e7116', '0x9beb072b593fdae18f403f7e8f80875df1eaa258ccc1c01e1f51a25aeef15578', true, current_timestamp, 'indexer');


INSERT INTO chain_pairs
    (from_chain_id, to_chain_id, is_active, created_at, created_by)
VALUES
    (80001.00::bigint, 14000.00::bigint, true, current_timestamp, 'indexer');

INSERT INTO whitelisted_tokens
    (chain_id, address, created_at, created_by, decimals, fee_flat, fee_percentage, is_active, is_enabled, is_wrapped_token, max_amount, min_amount, name, symbol, original_token_id)
VALUES
    (80001::bigint, '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE', current_timestamp, 'indexer',18, 0, 0, true, true, false, 1000000000000000000, 1, 'POLYGON', 'MATIC', null);


INSERT INTO user_on_chain (id, address, chain_id, user_id)
VALUES ('ebb3f12c-fec9-4162-b052-9eca0d472a99', '0xb28f23d613fc337873fac136e2bc04fe4ab6041f', 80001, '2815e322-0cbc-4619-8c86-50534401822f') ON CONFLICT DO NOTHING;;

INSERT INTO user_on_chain (id, address, chain_id, user_id)
VALUES ('93fc7644-c64b-48ce-b15c-d3cc8f58b4b1', '0x28dedfe85c528ea591b68ea6654999ef9d1a735a', 80001, 'f8305b6c-4613-4537-a8dd-2673117234cb') ON CONFLICT DO NOTHING;


INSERT INTO cron_jobs_config
    (chain_id, block_window, name, interval, class_name, method_name, is_active, created_at, created_by)
VALUES
    (80001::bigint,    0.00::bigint, 'guardian-job'       , 60000, 'com.cxptek.bridge.cron.GuardianScheduler', 'run',        true, current_timestamp, 'indexer'),
    (80001::bigint, 1000.00::bigint, 'polygon-indexer-job', 60000, 'com.cxptek.bridge.cron.IndexerScheduler' , 'run',        true, current_timestamp, 'indexer'),
    (80001::bigint,    0.00::bigint, 'monitor-signed-job' , 60000, 'com.cxptek.bridge.cron.MonitorScheduler' , 'runSigned',  true, current_timestamp, 'indexer'),
    (80001::bigint,    0.00::bigint, 'monitor-pending-job', 60000, 'com.cxptek.bridge.cron.MonitorScheduler' , 'runPending', true, current_timestamp, 'indexer');