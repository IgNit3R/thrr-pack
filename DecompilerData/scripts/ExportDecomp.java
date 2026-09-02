// Export all functions + decompiled C from Ghidra headless.
//@category THExport
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.*;
import ghidra.util.task.ConsoleTaskMonitor;
import java.io.*;
import java.util.*;

public class ExportDecomp extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        String outdir = args.length > 0 ? args[0] : getProjectRootFolder() != null ? "." : ".";
        new File(outdir).mkdirs();

        FunctionIterator it = currentProgram.getFunctionManager().getFunctions(true);
        List<Function> funcs = new ArrayList<>();
        while (it.hasNext()) funcs.add(it.next());
        println("total functions: " + funcs.size());

        DecompInterface di = new DecompInterface();
        DecompileOptions opts = new DecompileOptions();
        di.setOptions(opts);
        di.openProgram(currentProgram);
        ConsoleTaskMonitor mon = new ConsoleTaskMonitor();

        PrintWriter csv = new PrintWriter(new OutputStreamWriter(
            new FileOutputStream(new File(outdir, "functions.csv")), "UTF-8"));
        csv.println("entry,name,size,params,callees");

        PrintWriter cOut = new PrintWriter(new OutputStreamWriter(
            new FileOutputStream(new File(outdir, "decomp_all.c")), "UTF-8"));
        cOut.println("// Ghidra decompilation export: " + currentProgram.getName());
        cOut.println("// total functions: " + funcs.size());
        cOut.println();

        int count = 0;
        for (Function f : funcs) {
            long size = f.getBody().getNumAddresses();
            String entry = f.getEntryPoint().toString();
            List<String> callees = new ArrayList<>();
            Set<Function> called = f.getCalledFunctions(mon);
            for (Function cf : called) callees.add(cf.getName());
            Collections.sort(callees);
            csv.println(entry + "," + f.getName() + "," + size + "," + f.getParameterCount() + ",\"" + String.join(" ", callees) + "\"");

            String code;
            try {
                DecompileResults res = di.decompileFunction(f, 60, mon);
                if (res != null && res.decompileCompleted() && res.getDecompiledFunction() != null) {
                    code = res.getDecompiledFunction().getC();
                } else {
                    code = "// DECOMPILE FAILED: " + f.getName();
                }
            } catch (Exception e) {
                code = "// EXCEPTION: " + f.getName() + " / " + e;
            }
            cOut.println("// ===== FUNC " + f.getName() + " @ " + entry + " (size=" + size + ") =====");
            cOut.println(code);
            cOut.println();
            count++;
            if (count % 200 == 0) println("decompiled " + count + "/" + funcs.size());
        }
        csv.close();
        cOut.close();
        println("DONE. functions: " + count + " -> " + outdir);
    }
}
