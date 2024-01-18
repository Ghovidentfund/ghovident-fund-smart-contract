// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentPool.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GhovidentDeployer is IGhovidentDeployer {
    struct Parameters {
        address factory;
        string name;
        address company;
        uint256 createdAt;
    }

    Parameters public override parameters;

    function deploy(
        address factory,
        string memory name,
        address company,
        uint256 createdAt
    ) internal returns (address pool) {
        parameters = Parameters({
            factory: factory,
            name: name,
            company: company,
            createdAt: createdAt
        });
        pool = address(
            new GhovidentPool{
                salt: keccak256(abi.encode(name, company, createdAt))
            }()
        );
        delete parameters;
    }
}
