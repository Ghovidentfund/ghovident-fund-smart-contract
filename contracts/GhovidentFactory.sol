// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IGhovidentFactory.sol";
import "./GhovidentDeployer.sol";

contract GhovidentFactory is IGhovidentFactory, GhovidentDeployer {
    // mapping address company -> address pool
    mapping(address => address) public getPools;

    function createPool(
        string memory name,
        address company,
        uint256 createdAt
    ) external override returns (address pool) {
        pool = deploy(address(this), name, company, createdAt);
        getPools[company] = pool;
        emit PoolCreated(name, company, createdAt, pool);
    }
}
