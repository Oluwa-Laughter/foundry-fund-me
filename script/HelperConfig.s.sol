// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        address priceFeed;
    }

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    NetworkConfig public activeNetWorkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetWorkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetWorkConfig = getMainnetEthConfig();
        } else {
            activeNetWorkConfig = getCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });

        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function getCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if(activeNetWorkConfig.priceFeed != address(0) ) {
            return activeNetWorkConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mockPricefeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPricefeed)
        });

        return anvilConfig;
    }
}
