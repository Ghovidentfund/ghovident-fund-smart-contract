// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentDeployer {
    function parameters()
        external
        view
        returns (
            address factory,
            string memory name,
            address company,
            uint256 createdAt
        );
}
