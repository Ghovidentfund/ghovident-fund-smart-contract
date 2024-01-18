// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentFactory {
    event PoolCreated(
        string name,
        address indexed company,
        uint256 createdAt,
        address pool
    );

    function createPool(
        string memory name,
        address company,
        uint256 createdAt
    ) external returns (address pool);
}
