INSERT INTO contracts
    (address, chain_id, name, version, is_active, created_by, created_at, abi)
VALUES
    ('0x59255b8fFdbC6f54e62A20D7dC3Ed763B3843e02', 80001::bigint, 'Bridge Core', 1, true, 'indexer', current_timestamp, '[]'),
    ('0x222a0F22525c9a80F3909851939817DfD4f1d268', 80001::bigint, 'Bridge Registry', 1, true, 'indexer', current_timestamp, '[]'),
    ('0x8753d1a2583bd6d3d298df7bfa2856f289468537', 80001::bigint, 'Token Transfer', 1, true, 'indexer', current_timestamp, '[]'),
    ('0x25D50B8bdE8cd12831be348a18686A923C53d335', 80001::bigint, 'Forwarder', 1, true, 'indexer', current_timestamp, '[]');

--- EVENTS

INSERT INTO events
    (name, chain_id, contract_address, topic, is_active, created_at, created_by)
VALUES
    ('BridgeMessage',   80001.00,      '0x59255b8fFdbC6f54e62A20D7dC3Ed763B3843e02', '0xbf2dddb56dbf8dd5f704a7e228dfdadec1bd4d0a0dfdd40dd453c67cfc4203c2', true, current_timestamp, 'indexer'),
    ('TokenUpdate',     80001.00,      '0x222a0F22525c9a80F3909851939817DfD4f1d268', '0x91727cba2d28e0b1ef9ac35db61f707d0ce9b18f094cf55006c00cd04fa473bf', true, current_timestamp, 'indexer'),
    ('TokenEnable',     80001.00,      '0x222a0F22525c9a80F3909851939817DfD4f1d268', '0xb3f82610f75fe4e2eafd8653b80b1de6ad1a7d00ecefabf909c3c0e7e74ee6d1', true, current_timestamp, 'indexer'),
    ('TokenDisable',    80001.00,      '0x222a0F22525c9a80F3909851939817DfD4f1d268', '0x6e72d60926f318fe6db41705b1a970ef2f81e56920da7a852e91146088a7912b', true, current_timestamp, 'indexer'),
    ('RegisterToken',   80001.00,      '0x222a0F22525c9a80F3909851939817DfD4f1d268', '0x202b7569ffce248bc59155deb84d4be223a21f5c209f213984211bbb253e89e0', true, current_timestamp, 'indexer'),
    ('RegisterWrappedToken', 80001.00, '0x222a0F22525c9a80F3909851939817DfD4f1d268', '0x123aa379e86e557507657254e11aec6b78d8de142c343d3a515980d6365d3215', true, current_timestamp, 'indexer'),
    ('ClaimToken',      80001.00,      '0x8753d1a2583bd6d3d298df7bfa2856f289468537', '0x9beb072b593fdae18f403f7e8f80875df1eaa258ccc1c01e1f51a25aeef15578', true, current_timestamp, 'indexer');
