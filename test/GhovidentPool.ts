import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { GhovidentFactory, GhovidentPool } from "../typechain-types";

describe("GhovidentPool", function () {
  const poolName = "Ghovident Fund";
  async function setUpFixture() {
    const [owner, emp1, emp2] = await ethers.getSigners();
    const GhovidentFactory = await ethers.getContractFactory(
      "GhovidentFactory"
    );
    const ghovidentFactory = await GhovidentFactory.deploy();
    await ghovidentFactory.createPool(poolName);
    const ghovidentPool = await ethers.getContractAt(
      "GhovidentPool",
      await ghovidentFactory.pools(0)
    );
    return { ghovidentFactory, ghovidentPool, owner, emp1, emp2 };
  }

  describe("Deployment", async function () {
    it("Should pool name is Ghovident Fund", async function () {
      const { ghovidentPool } = await loadFixture(setUpFixture);
      expect(await ghovidentPool.name()).to.equal(poolName);
    });
  });

  describe("register company", async function () {
    it("Should register company", async function () {
      const { ghovidentPool, owner, emp1, emp2 } = await loadFixture(
        setUpFixture
      );
      console.log("ghovidentPool", await ghovidentPool.getAddress());
      console.log("emp1", emp1.address);
      console.log("emp2", emp2.address);
      const ghovidentPoolContract = await ethers.getContractAt(
        "GhovidentPool",
        await ghovidentPool.getAddress()
      );

      await ghovidentPoolContract.registerCompany(
        "JJ company",
        ["emp1", "emp2"],
        [emp1.address, emp2.address],
        // [15000, 30000],
        [1234, 5678],
        // [3, 8]
        [400, 800]
      );
      const company = await ghovidentPoolContract.getCompany(owner.address);
      expect(company.name).to.equal("JJ company");
      expect(company.employees[0].employeeAddress).to.equal(emp1.address);
      expect(company.employees[1].employeeAddress).to.equal(emp2.address);
      expect(await ghovidentPoolContract.totalInvestment()).to.equal(1200);
    });
  });
});
