import ctypes, ctypes.wintypes as wt

user32 = ctypes.windll.user32
pid_target = 29060
windows = []

WNDENUMPROC = ctypes.WINFUNCTYPE(wt.BOOL, wt.HWND, wt.LPARAM)

def cb(hwnd, lparam):
    pid = wt.DWORD()
    user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
    if pid.value == pid_target:
        buf = ctypes.create_unicode_buffer(256)
        user32.GetWindowTextW(hwnd, buf, 256)
        cls = ctypes.create_unicode_buffer(256)
        user32.GetClassNameW(hwnd, cls, 256)
        vis = user32.IsWindowVisible(hwnd)
        enabled = user32.IsWindowEnabled(hwnd)
        windows.append((hwnd, cls.value, buf.value, bool(vis), bool(enabled)))
    return True

user32.EnumWindows(WNDENUMPROC(cb), 0)
print('top-level windows of pid %d:' % pid_target)
for w in windows:
    print('  hwnd=%s class=%r title=%r visible=%s enabled=%s' % w
)
