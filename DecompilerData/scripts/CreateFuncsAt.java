// Create functions at specified addresses before analysis
//@category THExport
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSet;
import ghidra.program.model.listing.Function;
import ghidra.program.model.symbol.SourceType;

public class CreateFuncsAt extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        for (String a : args) {
            Address addr = currentProgram.getAddressFactory().getAddress(a);
            try {
                Function f = currentProgram.getFunctionManager()
                    .createFunction("TASK_" + a.substring(2), addr,
                                    new AddressSet(addr, addr), SourceType.USER_DEFINED);
                disassemble(addr);
                println("CreateFunction " + a + " -> " + (f != null ? f.getName() : "FAILED"));
            } catch (Exception e) {
                println("CreateFunction " + a + " EXC: " + e);
            }
        }
    }
}
