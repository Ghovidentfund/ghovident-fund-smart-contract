// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentInvestment {
    function stake(address pool, uint256 amount) external;

    function loan() external;
}
