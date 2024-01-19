// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentFactory {
    event PoolCreated(
        string name,
        string email,
        string country,
        address indexed company,
        string link,
        uint256 createdAt,
        address pool
    );

    function createPool(
        string memory name,
        string memory email,
        string memory country,
        string memory link,
        uint256 createdAt
    ) external returns (address pool);
}
