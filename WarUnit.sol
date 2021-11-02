pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "Game_Object.sol";
import "Station.sol";
import "Game_Interface.sol";
contract WarUnit is Game_Object {
    Game_Object BaseSt;
    uint AttackPower;

    constructor(Station x) public {
        tvm.accept();
        x.addUnit(this);
    }
    function BaseDeath() external {
        tvm.accept();
         require(msg.sender == BaseSt, 102);
        destroy();
    } 
    function UnitDeath() internal {
        address unitAddress = address(this);
        BaseSt.deleteUnit(unitAddress);
        destroy();
    } 
    function getArmor() public override returns(uint){
        tvm.accept();
        return armor;
    }
    function getAttackPower() public  returns(uint){
        tvm.accept();
        return AttackPower;
    }
        function attack(Game_Interface attackAddress) internal {
        attackAddress.takeAttack(AttackPower);
    }
}