// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {FundMe} from "../src/FunMe.sol";
import {Script} from "forge-std/Script.sol";

contract DeployFundMe is Script {
    function run() external {
        vm.startBroadcast();
        FundMe fundMe = new FundMe();
        vm.stopBroadcast();
    }
}
