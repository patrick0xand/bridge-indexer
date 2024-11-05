package com.cxptek.bridge.model.properties;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AccountProperties {
    private String address;
    @JsonIgnore
    private String privateKey;
    @JsonIgnore
    private String seed;

    public AccountProperties(String address) {
        this.address = address;
    }

    public AccountProperties(String address, String privateKey) {
        this.address = address;
        this.privateKey = privateKey;
    }
}
