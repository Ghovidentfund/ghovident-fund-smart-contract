import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("GhovidentFactory", function () {
  const poolName = "Ghovident Fund";
  async function deployGhovidentFactoryFixture() {
    const [owner, otherAccount] = await ethers.getSigners();
    const GhovidentFactory = await ethers.getContractFactory(
      "GhovidentFactory"
    );
    const ghovidentFactory = await GhovidentFactory.deploy();
    return { ghovidentFactory, owner, otherAccount };
  }

  describe("Create pool", async function () {
    it("Should pool created", async function () {
      const { ghovidentFactory, owner } = await loadFixture(
        deployGhovidentFactoryFixture
      );
      await ghovidentFactory.createPool(poolName);
      const pool = await ghovidentFactory.pools(0);
      const poolContract = await ethers.getContractAt("GhovidentPool", pool);
      const poolFactory = await poolContract.factory();
      expect(poolFactory).to.equal(await ghovidentFactory.getAddress());
      expect(await poolContract.name()).to.equal(poolName);
    });
  });
});
