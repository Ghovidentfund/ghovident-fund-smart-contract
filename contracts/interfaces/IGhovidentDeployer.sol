// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentDeployer {
    function parameters()
        external
        view
        returns (
            address factory,
            string memory name,
            string memory email,
            string memory country,
            address company,
            string memory link,
            uint256 createdAt
        );
}
