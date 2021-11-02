pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import 'WarUnit.sol';

contract warrior is WarUnit {
    constructor(Game_Object AddressBase) public {
        address unitAddress = address(this);
        AddressBase.addWarUnit(unitAddress);
        BaseSt = AddressBase;
        HP = 10;
        attackPower = 4;
    }
}