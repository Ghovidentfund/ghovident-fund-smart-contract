// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentDeployer.sol";
import "./interfaces/IGhovidentFactory.sol";

contract GhovidentFactory is IGhovidentFactory, GhovidentDeployer {
    // mapping address company -> address pool
    mapping(address => address) public getPools;

    function createPool(
        string memory name,
        string memory email,
        string memory country,
        string memory link,
        uint256 createdAt
    ) external override returns (address pool) {
        pool = deploy(
            address(this),
            name,
            email,
            country,
            msg.sender,
            link,
            createdAt
        );
        getPools[msg.sender] = pool;
        emit PoolCreated(
            name,
            email,
            country,
            msg.sender,
            link,
            createdAt,
            pool
        );
    }
}
