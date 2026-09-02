# Export all functions + decompiled C from Ghidra headless.
#@category THExport
#@runtime PyGhidra
import os, json

args = getScriptArgs()
outdir = args[0] if args else os.getcwd()
os.makedirs(outdir, exist_ok=True)

program = currentProgram
fm = program.getFunctionManager()
listing = program.getListing()

from ghidra.app.decompiler import DecompInterface
from ghidra.util.task import ConsoleTaskMonitor

di = DecompInterface()
di.openProgram(program)
monitor = ConsoleTaskMonitor()

funcs = [f for f in fm.getFunctions(True)]
summary = []
c_out = open(os.path.join(outdir, 'decomp_all.c'), 'w', encoding='utf-8', errors='replace')
c_out.write('// Ghidra decompilation export: %s\n// total functions: %d\n\n' % (program.getName(), len(funcs)))

count = 0
for f in funcs:
    body = f.getBody()
    size = body.getNumAddresses()
    entry = f.getEntryPoint()
    callees = set()
    called = f.getCalledFunctions(monitor)
    for cf in called:
        callees.append if False else callees.add(cf.getName())
    summary.append({
        'name': f.getName(),
        'entry': str(entry),
        'size': int(size),
        'params': f.getParameterCount(),
        'callees': sorted(callees),
    })
    try:
        res = di.decompileFunction(f, 60, monitor)
        if res.decompileCompleted():
            code = res.getDecompiledFunction().getC()
        else:
            code = '// DECOMPILE FAILED: %s\n' % f.getName()
    except Exception as e:
        code = '// EXCEPTION: %s / %s\n' % (f.getName(), e)
    c_out.write('// ===== FUNC %s @ %s (size=%d) =====\n' % (f.getName(), entry, size))
    c_out.write(code + '\n\n')
    count += 1
    if count % 100 == 0:
        print('decompiled %d/%d' % (count, len(funcs)))

c_out.close()

with open(os.path.join(outdir, 'functions.json'), 'w', encoding='utf-8') as fp:
    json.dump(summary, fp, ensure_ascii=False, indent=1)

print('DONE. functions: %d -> %s' % (count, outdir))
