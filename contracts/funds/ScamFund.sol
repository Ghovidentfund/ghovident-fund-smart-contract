// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IGhovidentInvestment.sol";

contract ScamFund is IGhovidentInvestment {
    uint public totalStaked;

    constructor() {}

    function stake(uint _amout) external override {
        totalStaked += _amout;
    }

    function loan() external override {}
}
