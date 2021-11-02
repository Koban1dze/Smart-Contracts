pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "Game_Object.sol";
contract Station is Game_Object {
    mapping (address=>uint) unitAdMap;
    Game_Object[] unitArray;
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function getArmor(uint ArmorValue) public {
        tvm.accept();
        armor = ArmorValue;
    }

    function addUnit(Game_Object unitAddress) external public {
        tvm.accept();
        unitArray.push(unitAddress);

    }

    function deleteUnit(Game_Object unitAddress) external override {
         tvm.accept();
        delete unitArray[unitAdMap[unitAddress]];
    }

    function baseSuicide() public virtual {
        tvm.accept();
        destroy();
        for (uint i; i <= unitArray.length - 1; i++) {
        unitArray[i].BaseDeath();
    }
 }

}