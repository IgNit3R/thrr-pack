// ===== FUNC FUN_0043d550 @ 0043d550 (size=1440) =====

void FUN_0043d550(void)

{
  ushort uVar1;
  undefined4 *puVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  LPCVOID _Memory;
  int *piVar6;
  byte *lpBuffer;
  undefined4 extraout_ECX;
  undefined4 extraout_ECX_00;
  undefined4 extraout_ECX_01;
  int *piVar7;
  int *piVar8;
  uint uVar9;
  int *piVar10;
  int iVar11;
  int *piVar12;
  char *_Format;
  undefined4 *local_118;
  int *local_114;
  DWORD local_110;
  int local_10c;
  int *local_108;
  char local_104 [256];
  uint local_4;
  
  piVar7 = DAT_004b68d0;
  local_4 = DAT_004ac138 ^ (uint)&local_118;
  local_108 = DAT_004b68d0;
  if (*DAT_004b68d0 == 0) {
    __security_check_cookie(local_4 ^ (uint)&local_118);
    return;
  }
  __chdir(&DAT_004d1801);
  FUN_0046c71d("bestshot");
  if ((DAT_004b68e0 == (int *)0x0) || (DAT_004b68c4 == 0)) goto LAB_0043d898;
  local_114 = (int *)*DAT_004b68e0;
  piVar6 = local_114 + DAT_004b308c * 0x23;
  iVar3 = (int)piVar6 * 0xf4;
  local_110 = DAT_004b308c;
  if ((char)piVar7[(int)piVar6 * 0x3d + 0x1508] == '\0') goto LAB_0043d898;
  if (-1 < piVar7[(int)piVar6 * 0x3d + 0x1509]) {
    FUN_00433a50(DAT_004b68c4);
  }
  piVar10 = DAT_004b68d0;
  iVar11 = DAT_004b68c4;
  DAT_004b68d0[(DAT_004b308c * 0x8c + DAT_004b30ac) * 0x12 + 0x12e] =
       *(int *)(piVar7[(int)piVar6 * 0x3d + 0x1509] * 0xec + 0xab4 + DAT_004b68c4);
  iVar5 = piVar7[(int)piVar6 * 0x3d + 0x1509];
  iVar4 = DAT_004b308c * 0x8c + DAT_004b30ac;
  piVar10[iVar4 * 0x12 + 0x12a] = *(int *)(iVar5 * 0xec + 0xaa4 + iVar11);
  piVar10[iVar4 * 0x12 + 299] = *(int *)(iVar5 * 0xec + 0xaa8 + iVar11);
  if ((piVar7[(int)piVar6 * 0x3d + 0x1509] < 0) ||
     (*(int *)(piVar7[(int)piVar6 * 0x3d + 0x1509] * 0xec + 0xb1c + iVar11) == 0)) {
    FUN_0043e2c0((int)(piVar7 + (int)piVar6 * 0x3d + 0x14cf),
                 (uint)*(ushort *)(piVar7 + (int)piVar6 * 0x3d + 0x14d2));
  }
  piVar10 = local_108;
  uVar1 = *(ushort *)((int)piVar7 + iVar3 + 0x534a);
  *(ushort *)(piVar7 + (int)piVar6 * 0x3d + 0x14d5) =
       *(ushort *)(piVar7 + (int)piVar6 * 0x3d + 0x14d2) >> 1;
  *(ushort *)((int)piVar7 + iVar3 + 0x5356) = uVar1 >> 1;
  *(undefined2 *)((int)local_108 + (int)piVar6 * 0x48 + 0x47e) = 0;
  local_108[(int)piVar6 * 0x12 + 0x120] = 0x48;
  *(undefined2 *)(local_108 + (int)piVar6 * 0x12 + 0x11f) = 0x4353;
  piVar7[(int)piVar6 * 0x3d + 0x14f3] = 0;
  local_118 = (undefined4 *)FUN_00464030((int *)piVar7[(int)piVar6 * 0x3d + 0x150b]);
  iVar5 = FUN_00464030(piVar7 + (int)piVar6 * 0x3d + 0x14f4);
  local_118 = (undefined4 *)((int)local_118 + iVar5);
  iVar5 = FUN_00464030(piVar7 + (int)piVar6 * 0x3d + 0x14cf);
  piVar7[(int)piVar6 * 0x3d + 0x14f3] = iVar5 + (int)local_118;
  piVar10[(int)piVar6 * 0x12 + 300] = iVar5 + (int)local_118;
  iVar5 = DAT_004b68e0[1];
  if (local_110 == 0) {
    if (iVar5 == 0xc) {
      _sprintf(local_104,"bestshot/bs_ex_%d.dat",DAT_004b68e0[2] + 1);
    }
    else {
      iVar11 = DAT_004b68e0[2];
      if (iVar5 == 0xd) {
        _sprintf(local_104,"bestshot/bs_sp_%d.dat");
      }
      else {
        _Format = "bestshot/bs_%.2d_%d.dat";
LAB_0043d807:
        _sprintf(local_104,_Format,iVar5 + 1,iVar11 + 1);
      }
    }
  }
  else if (iVar5 == 0xc) {
    _sprintf(local_104,"bestshot/bs2_ex_%d.dat",DAT_004b68e0[2] + 1);
  }
  else {
    if (iVar5 != 0xd) {
      iVar11 = DAT_004b68e0[2];
      _Format = "bestshot/bs2_%.2d_%d.dat";
      goto LAB_0043d807;
    }
    _sprintf(local_104,"bestshot/bs2_sp_%d.dat",DAT_004b68e0[2] + 1);
  }
  FUN_004633f0();
  FUN_00463570(extraout_ECX,piVar7 + (int)piVar6 * 0x3d + 0x14cf);
  FUN_00463570(extraout_ECX_00,piVar7 + (int)piVar6 * 0x3d + 0x14f4);
  _Memory = (LPCVOID)FUN_0044add0((byte *)piVar7[(int)piVar6 * 0x3d + 0x150b],
                                  (uint)*(byte *)((int)piVar7 + iVar3 + 0x5341) *
                                  (uint)*(ushort *)((int)piVar7 + iVar3 + 0x534a) *
                                  (uint)*(ushort *)(piVar7 + (int)piVar6 * 0x3d + 0x14d2),
                                  (int *)&local_118);
  FUN_00463570(extraout_ECX_01,_Memory);
  FUN_00463620();
  *(undefined1 *)(piVar7 + (int)piVar6 * 0x3d + 0x1508) = 0;
  _free(_Memory);
  FUN_0042b7d0(local_108,(int)local_114);
  piVar7 = local_108;
LAB_0043d898:
  local_118 = _malloc(0x200000);
  puVar2 = (undefined4 *)*piVar7;
  *local_118 = *puVar2;
  local_118[1] = puVar2[1];
  local_118[2] = puVar2[2];
  local_118[3] = puVar2[3];
  local_118[4] = puVar2[4];
  local_118[5] = puVar2[5];
  local_10c = 0x18;
  local_110 = 0;
  piVar6 = piVar7 + 0x121;
  do {
    uVar9 = 0;
    local_114 = (int *)(local_10c + (int)local_118);
    do {
      piVar10 = piVar6 + -2;
      if ((short)*piVar10 == 0x4353) {
        iVar3 = 0;
        iVar11 = 0;
        piVar6[4] = local_110;
        piVar6[1] = uVar9;
        *piVar6 = 0;
        iVar5 = 9;
        piVar7 = piVar10;
        do {
          iVar3 = iVar3 + *piVar7;
          iVar11 = iVar11 + piVar7[1];
          piVar7 = piVar7 + 2;
          iVar5 = iVar5 + -1;
        } while (iVar5 != 0);
        local_10c = local_10c + 0x48;
        *piVar6 = iVar3 + iVar11;
        piVar8 = local_114 + 0x12;
        piVar12 = local_114;
        for (iVar3 = 0x12; piVar7 = local_108, local_114 = piVar8, iVar3 != 0; iVar3 = iVar3 + -1) {
          *piVar12 = *piVar10;
          piVar10 = piVar10 + 1;
          piVar12 = piVar12 + 1;
        }
      }
      uVar9 = uVar9 + 1;
      piVar6 = piVar6 + 0x12;
    } while (uVar9 < 0x8c);
    local_110 = local_110 + 1;
  } while ((int)local_110 < 2);
  iVar11 = 0;
  piVar7[4] = 0;
  iVar5 = 0x8e;
  iVar3 = 0;
  piVar6 = piVar7 + 2;
  do {
    iVar3 = iVar3 + *piVar6;
    iVar11 = iVar11 + piVar6[1];
    piVar6 = piVar6 + 2;
    iVar5 = iVar5 + -1;
  } while (iVar5 != 0);
  piVar7[4] = iVar3 + iVar11 + *piVar6;
  piVar6 = piVar7 + 2;
  piVar10 = (int *)(local_10c + (int)local_118);
  for (iVar3 = 0x11d; iVar3 != 0; iVar3 = iVar3 + -1) {
    *piVar10 = *piVar6;
    piVar6 = piVar6 + 1;
    piVar10 = piVar10 + 1;
  }
  *(int *)(*piVar7 + 0x14) = local_10c + 0x45c;
  lpBuffer = (byte *)FUN_0044add0((byte *)(local_118 + 6),*(int *)(*piVar7 + 0x14),
                                  (int *)(*piVar7 + 0x10));
  *(int *)(*piVar7 + 4) = *(int *)(*piVar7 + 0x10) + 0x18;
  FUN_00462f30(lpBuffer,*(uint *)(*piVar7 + 0x10),'5',0x10,*(uint *)(*piVar7 + 0x10));
  iVar3 = FUN_004633f0();
  if (iVar3 == 0) {
    if (((DAT_004ad270 != (HANDLE)0xffffffff) &&
        (WriteFile(DAT_004ad270,(LPCVOID)*piVar7,0x18,&local_110,(LPOVERLAPPED)0x0),
        local_110 != 0x18)) && (CloseHandle(DAT_004ad270), (DAT_004d1260 & 0x8000) != 0)) {
      LeaveCriticalSection((LPCRITICAL_SECTION)&DAT_004d1510);
      DAT_004d1602 = DAT_004d1602 + -1;
    }
    piVar7 = *(int **)(*piVar7 + 0x10);
    if (DAT_004ad270 != (HANDLE)0xffffffff) {
      WriteFile(DAT_004ad270,lpBuffer,(DWORD)piVar7,(LPDWORD)&local_114,(LPOVERLAPPED)0x0);
      if ((piVar7 != local_114) && (CloseHandle(DAT_004ad270), (DAT_004d1260 & 0x8000) != 0)) {
        LeaveCriticalSection((LPCRITICAL_SECTION)&DAT_004d1510);
        DAT_004d1602 = DAT_004d1602 + -1;
      }
      if ((DAT_004ad270 != (HANDLE)0xffffffff) &&
         (CloseHandle(DAT_004ad270), (DAT_004d1260 & 0x8000) != 0)) {
        LeaveCriticalSection((LPCRITICAL_SECTION)&DAT_004d1510);
        DAT_004d1602 = DAT_004d1602 + -1;
      }
    }
    _free(lpBuffer);
    _free(local_118);
    __chdir(&DAT_004d2801);
  }
  __security_check_cookie(local_4 ^ (uint)&local_118);
  return;
}



