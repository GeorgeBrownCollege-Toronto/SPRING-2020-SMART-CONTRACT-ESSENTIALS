
const Ballot = artifacts.require("Ballot");
const truffleAssert = require("truffle-assertions");

contract("Ballot", function (accounts) {

  describe("Initial deployment", async () => {
    it("should assert true", async function () {
      // TODO:contract should be deployed successfully
    });

    it("should initialize the owner as the chairperson", async () => {
      // TODO
    });
  });

  describe("Registration", () => {
    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });

    it("will revert if non chairperson registers the voter", async () => {
      // TODO
    });

    it("chair person can register the voters", async () => {
      // TODO
    });
  });

  describe("Change State", () => {

    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });

    it("will revert if non-chairperson changes the state", async () => {
      // TODO
    });

    it("will revert when voter tries to vote during Reg state", async () => {
      // TODO
    });

    it("chair person can change the state", async () => {
      // TODO
    });

    it("will revert if changeState() is supplied invalid state", async () => {
      // TODO
    });
  });

  describe("Vote", () => {
    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });
    it("Registered voters can vote", async () => {
      // TODO
    });
  });

  describe("reqWinner", () => {

    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });

    it("will revert when winner is requested if winningVoteCount is less than 3", async () => {
     // TODO
    });
  });
});

contract("Ballot", function (accounts) {
  before(async function () {
    // TODO deployment of Ballot should be successful
  });

  describe("Registration", () => {
    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });
    it("chair person can register multiple voters", async () => {
      // TODO
    });
  });

  describe("Vote", () => {
    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });
    it("Multiple registered voters can vote", async () => {
      // TODO
    });

    it("Should revert when voted user tries to vote again", async () => {
      // TODO
    });

    it("Should revert when voter tires to vote for invalid proposal", async () => {
      // TODO
    });

  });

  describe("reqWinner", () => {
    let BallotInstance;
    beforeEach(async () => {
      // get ballot
    });
    it("Get winners after voting state is Done", async () => {
      // TODO
    });
  });

});