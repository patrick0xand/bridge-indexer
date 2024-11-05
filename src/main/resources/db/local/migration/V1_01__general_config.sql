INSERT INTO payload_types
    (name, is_active, version, created_at, created_by)
VALUES
    ('TokenTransfer', true, 1, current_timestamp, 'indexer');

-- TEAMS
INSERT INTO team (name) VALUES ('OPERATION') ON CONFLICT DO NOTHING;

-- ROLES
INSERT INTO role (name) VALUES ('MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO role (name) VALUES ('OPERATOR') ON CONFLICT DO NOTHING;

-- USER OPERATOR
INSERT INTO iuser (id, enabled, name, token_expired, team_name)
VALUES ('2815e322-0cbc-4619-8c86-50534401822f', true, 'ARG Operator', false, 'OPERATION') ON CONFLICT DO NOTHING;

INSERT INTO iuser_roles (users_id, roles_name)
VALUES ('2815e322-0cbc-4619-8c86-50534401822f', 'OPERATOR') ON CONFLICT DO NOTHING;

-- USER MANAGER
INSERT INTO iuser (id, enabled, name, token_expired, team_name)
VALUES ('f8305b6c-4613-4537-a8dd-2673117234cb', true, 'ARG Manager', false, 'OPERATION') ON CONFLICT DO NOTHING;

INSERT INTO iuser_roles (users_id, roles_name)
VALUES ('f8305b6c-4613-4537-a8dd-2673117234cb', 'MANAGER') ON CONFLICT DO NOTHING;


DROP TABLE IF EXISTS coin_mappings CASCADE;

CREATE TABLE IF NOT EXISTS coin_mappings (
    coin_symbol     varchar(50) not null,
    coin_id         varchar(50) not null,
    provider_id     varchar(50) not null,
    price           numeric(19,2),
    updated_at      timestamp without time zone
);

ALTER TABLE ONLY coin_mappings
    ADD CONSTRAINT coin_mappings_pkey PRIMARY KEY (coin_symbol);

ALTER TABLE coin_mappings
    ADD CONSTRAINT coin_mappings_ukey UNIQUE (provider_id, coin_symbol);

INSERT INTO coin_mappings
    (coin_symbol, coin_id, provider_id)
VALUES
    ('BTC', 'bitcoin', 'COINGECKO'),
    ('ETH', 'ethereum', 'COINGECKO'),
    ('USDT', 'tether', 'COINGECKO'),
    ('BNB', 'binancecoin', 'COINGECKO'),
    ('TRX', 'tron', 'COINGECKO'),
    ('MATIC', 'matic-network', 'COINGECKO'),
    ('DAI', 'dai', 'COINGECKO'),
    ('VIC', 'vnd', 'COINGECKO'),
    ('SOL', 'solana', 'COINGECKO'),
    ('USDC', 'usd-coin', 'COINGECKO'),
    ('XRP', 'ripple', 'COINGECKO'),
    ('ADA', 'cardano', 'COINGECKO'),
    ('AVAX', 'avalanche-2', 'COINGECKO'),
    ('DOT', 'polkadot', 'COINGECKO'),
    ('DOGE', 'dogecoin', 'COINGECKO');


ALTER TABLE claims
    ADD COLUMN IF NOT EXISTS
        amount numeric(128, 18) NOT NULL DEFAULT 0;


DROP TABLE IF EXISTS indexed_details CASCADE;

CREATE TABLE IF NOT EXISTS indexed_details (
    id                      bigint         not null,
    cron_job_history_id     bigint         not null,
    chain_id                bigint         not null,
    tx_hash                 varchar(255)   not null,
    block_number            bigint         not null,
    log_index               bigint         not null,
    event_name              varchar(255)   not null,
    event_topic             varchar(255)   not null,
    created_at              timestamp      not null,
    created_by              varchar(255)   not null,
    updated_at              timestamp,
    updated_by              varchar(255)
);

ALTER TABLE ONLY indexed_details
    ADD CONSTRAINT indexed_details_pkey PRIMARY KEY (id);

ALTER TABLE ONLY indexed_details
    ADD CONSTRAINT indexed_details_job_history_fkey
        FOREIGN KEY (cron_job_history_id) REFERENCES cron_jobs_history (id);

ALTER TABLE ONLY indexed_details
    ADD CONSTRAINT indexed_details_chain_fkey
        FOREIGN KEY (chain_id) REFERENCES chains (id);

CREATE SEQUENCE indexed_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE indexed_details_id_seq OWNED BY indexed_details.id;

ALTER TABLE ONLY indexed_details
    ALTER COLUMN id SET DEFAULT nextval('indexed_details_id_seq'::regclass);

--- TABLES

ALTER TABLE claims
    ADD COLUMN IF NOT EXISTS index_detail_id bigint;

ALTER TABLE ONLY claims
    ADD CONSTRAINT claims_index_details_fkey
        FOREIGN KEY (index_detail_id) REFERENCES indexed_details (id);

ALTER TABLE transactions
    ADD COLUMN IF NOT EXISTS index_detail_id bigint;

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_index_details_fkey
        FOREIGN KEY (index_detail_id) REFERENCES indexed_details (id);

ALTER TABLE whitelisted_tokens
    ADD COLUMN IF NOT EXISTS index_detail_id bigint;

ALTER TABLE ONLY whitelisted_tokens
    ADD CONSTRAINT whitelisted_tokens_index_details_fkey
        FOREIGN KEY (index_detail_id) REFERENCES indexed_details (id);


ALTER TABLE transactions
    ADD COLUMN IF NOT EXISTS
        fee_flat numeric(128, 18) NOT NULL DEFAULT 0;

ALTER TABLE transactions
    ADD COLUMN IF NOT EXISTS
        fee_percentage numeric(128, 18) NOT NULL DEFAULT 0;


-- MUMBAI CHAIN
INSERT INTO chains
    (id, name, code, coin_decimals, coin_name, coin_symbol, eip1559supported, min_block_confirmation, api_endpoint, endpoint, explorer, platform, public_endpoint, is_active, created_at, created_by)
VALUES
    (80001.00, 'POLYGON', 'POLYGON', 18, 'MATIC', 'MATIC', true, 10,
     'https://api-mumbai.polygonscan.com/',
     'https://side-evocative-slug.matic-testnet.quiknode.pro/afa28e9790ad9afb88979a9daf6f783e7ae8cdbb',
     'https://mumbai.polygonscan.com/',
     'ETHEREUM',
     'https://endpoints.omniatech.io/v1/matic/mumbai/public',
     true, current_timestamp, 'indexer');

 ----- SEPOLIA CHAIN
 INSERT INTO chains
     (id, name, code, coin_decimals, coin_name, coin_symbol, eip1559supported, min_block_confirmation, api_endpoint, endpoint, explorer, platform, public_endpoint, is_active, created_at, created_by)
 VALUES
     (11155111::bigint, 'SEPOLIA', 'SEPOLIA', 18, 'ETHER', 'ETH', false, 10,
      'https://eth-sepolia.g.alchemy.com/v2/demo',
      'https://eth-sepolia.g.alchemy.com/v2/Syiea-k536mdH9_zvvXfDg54I2YRqMCx',
      'https://sepolia.etherscan.io',
      'ETHEREUM',
      'https://endpoints.omniatech.io/v1/eth/sepolia/public',
      true, current_timestamp, 'indexer');


----- VCHAIN TESTNET
INSERT INTO chains
    (id, name, code, coin_decimals, coin_name, coin_symbol, eip1559supported, min_block_confirmation, api_endpoint, endpoint, explorer, platform, public_endpoint, is_active, created_at, created_by)
VALUES
    (14000::bigint, 'VCHAIN_TESTNET', 'VCHAIN_TESTNET', 18, 'VIC', 'VIC', true, 10,
     'https://testnet-vch.vcex.network/api',
     'https://data-seed-prevch-1-s1.vcex.network',
     'https://testnet-vch.vcex.network/',
     'ETHEREUM',
     'https://data-seed-prevch-1-s1.vcex.network',
     true, current_timestamp, 'indexer');