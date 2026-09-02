// ===== FUNC FUN_00430ad0 @ 00430ad0 (size=8007) =====

undefined8 __fastcall FUN_00430ad0(undefined4 param_1,int *param_2,int param_3)

{
  float fVar1;
  double dVar2;
  int *piVar3;
  uint uVar4;
  int *piVar5;
  undefined4 *puVar6;
  int *piVar7;
  uint *puVar8;
  undefined4 *puVar9;
  float *pfVar10;
  int iVar11;
  undefined4 extraout_ECX;
  undefined4 uVar12;
  undefined4 extraout_ECX_00;
  undefined4 extraout_ECX_01;
  undefined4 extraout_ECX_02;
  undefined4 extraout_ECX_03;
  int extraout_ECX_04;
  void *this;
  void *this_00;
  int iVar13;
  undefined4 extraout_ECX_05;
  byte bVar14;
  float *extraout_EDX;
  int *extraout_EDX_00;
  int *extraout_EDX_01;
  int *extraout_EDX_02;
  float fVar15;
  char cVar16;
  int *unaff_EBX;
  float *pfVar17;
  float *pfVar18;
  ushort *puVar19;
  int *unaff_ESI;
  char *pcVar20;
  byte *pbVar21;
  void *pvVar22;
  int iVar23;
  float10 extraout_ST0;
  float10 fVar24;
  ulonglong uVar25;
  ulonglong uVar26;
  longlong lVar27;
  size_t _Size;
  int *local_1bc;
  int *piStack_1b8;
  float *local_1b4;
  ushort *local_1ac;
  int *local_1a8;
  uint local_1a4;
  float *local_1a0;
  int *local_19c;
  ushort *local_198;
  float local_194;
  float local_190;
  float local_18c;
  float *local_188;
  uint local_184;
  float *local_180;
  int *local_17c;
  float *local_178;
  int *local_174;
  int local_170;
  int local_16c;
  float *local_168;
  float local_164 [4];
  float local_154;
  float local_150;
  float local_14c;
  float local_148;
  float local_144;
  float local_140;
  float local_13c;
  float local_138;
  float local_128 [73];
  
  uVar4 = *(uint *)(param_3 + 0xa3ec);
  pvVar22 = DAT_004b68c8;
  if ((uVar4 & 1) == 0) goto LAB_00432702;
  iVar23 = *(int *)(param_3 + 0xa3f0);
  if (iVar23 == 1) {
    local_194 = *(float *)(param_3 + 0x9e0) + 128.0 + 192.0;
    local_190 = *(float *)(param_3 + 0x9e4) + 16.0;
    if (*(int *)(param_3 + 0xa3e8) == 0) {
      *(uint *)(param_3 + 0xa3ec) = uVar4 | 2;
      *(undefined4 *)(param_3 + 0x9fc) = 0;
      *(undefined4 *)(param_3 + 0xa00) = 0;
      *(undefined4 *)(param_3 + 0xa04) = *(undefined4 *)(param_3 + 0x9ec);
      *(undefined4 *)(param_3 + 0xa08) = *(undefined4 *)(param_3 + 0x9f0);
    }
    else {
      piVar7 = *(int **)(param_3 + 0x9ec);
      local_1a0 = (float *)((int)piVar7 / 2);
      local_1bc = piVar7;
      uVar25 = FUN_0048ca30(0,(int)piVar7 >> 0x1f);
      local_16c = (int)uVar25 - (int)local_1a0;
      *(undefined4 *)(param_3 + 0xa18) = 0;
      *(undefined4 *)(param_3 + 0xa14) = 0;
      *(undefined4 *)(param_3 + 0xa10) = 0;
      *(undefined4 *)(param_3 + 0xa0c) = 0;
      local_188 = (float *)((int)piVar7 + local_16c);
      iVar23 = local_16c;
      if ((float)local_16c < 128.0) {
        iVar23 = 0x80;
        *(undefined4 *)(param_3 + 0xa0c) = 1;
      }
      if (512.0 <= (float)(int)local_188) {
        local_188 = (float *)0x1ff;
        *(undefined4 *)(param_3 + 0xa14) = 1;
      }
      local_1a0 = *(float **)(param_3 + 0x9f0);
      iVar11 = (int)local_1a0 / 2;
      uVar25 = FUN_0048ca30(extraout_ECX,(int)local_1a0 >> 0x1f);
      local_1a8 = (int *)((int)uVar25 - iVar11);
      local_1a4 = (int)local_1a0 + (int)local_1a8;
      iVar11 = (int)local_1a8;
      if ((float)(int)local_1a8 < 16.0) {
        iVar11 = 0x10;
        *(undefined4 *)(param_3 + 0xa10) = 1;
      }
      if (464.0 <= (double)(int)local_1a4) {
        local_1a4 = 0x1cf;
        *(undefined4 *)(param_3 + 0xa18) = 1;
      }
      local_164[0] = (float)(iVar23 - local_16c);
      *(int *)(param_3 + 0x9fc) = iVar23 - local_16c;
      local_17c = (int *)(param_3 + 0x9fc);
      *(int *)(param_3 + 0xa00) = iVar11 - (int)local_1a8;
      local_164[1] = (float)(iVar11 - (int)local_1a8);
      local_174 = (int *)(param_3 + 0xa00);
      local_198 = (ushort *)(param_3 + 0xa04);
      *(int *)local_198 = (int)local_188 - local_16c;
      local_164[2] = (float)extraout_ST0;
      local_164[3] = (float)((int)local_188 - local_16c);
      local_19c = (int *)(param_3 + 0xa08);
      *local_19c = local_1a4 - (int)local_1a8;
      local_188 = (float *)(param_3 + 0xa4c);
      local_180 = local_164;
      iVar23 = 0;
      local_150 = (float)extraout_ST0;
      local_148 = (float)(int)(local_1a4 - (int)local_1a8);
      local_184 = 1;
      local_1ac = (ushort *)0x4;
      local_144 = (float)extraout_ST0;
      local_138 = (float)extraout_ST0;
      local_154 = local_164[1];
      local_14c = local_164[3];
      local_140 = local_164[0];
      local_13c = local_148;
      do {
        uVar4 = local_184 & 0x80000003;
        if ((int)uVar4 < 0) {
          uVar4 = (uVar4 - 1 | 0xfffffffc) + 1;
        }
        local_168 = local_164 + uVar4 * 3 + 1;
        local_1b4 = local_164 + uVar4 * 3;
        local_1a4 = 1;
        local_178 = local_188;
        local_170 = 4;
        do {
          uVar4 = local_1a4 & 0x80000003;
          if ((int)uVar4 < 0) {
            uVar4 = (uVar4 - 1 | 0xfffffffc) + 1;
          }
          iVar11 = FUN_00464fd0(*local_178,local_178[1],*(float *)(param_3 + 0xa4c + uVar4 * 0xc),
                                *(float *)(param_3 + (uVar4 * 3 + 0x294) * 4),*local_180,
                                local_180[1],*local_1b4,*local_168);
          if (iVar11 != 0) {
            iVar23 = iVar23 + 1;
          }
          local_178 = local_178 + 3;
          local_1a4 = local_1a4 + 1;
          local_170 = local_170 + -1;
        } while (local_170 != 0);
        local_184 = local_184 + 1;
        local_180 = local_180 + 3;
        local_1ac = (ushort *)((int)local_1ac + -1);
      } while (local_1ac != (ushort *)0x0);
      pfVar10 = local_164 + 1;
      local_1ac = (ushort *)0x4;
      local_170 = 0;
      pfVar17 = local_128 + iVar23 * 3 + 1;
      do {
        iVar11 = FUN_00464820(*local_188,*(float *)(param_3 + 0xa50),*(float *)(param_3 + 0xa58),
                              *(float *)(param_3 + 0xa5c),*(float *)(param_3 + 0xa64),
                              *(float *)(param_3 + 0xa68),pfVar10[-1],*pfVar10);
        pfVar18 = pfVar17;
        if (iVar11 != 0) {
          iVar23 = iVar23 + 1;
          pfVar17[-1] = extraout_EDX[-1];
          pfVar18 = pfVar17 + 3;
          *pfVar17 = *extraout_EDX;
        }
        pfVar10 = extraout_EDX + 3;
        local_1ac = (ushort *)((int)local_1ac + -1);
        pfVar17 = pfVar18;
      } while (local_1ac != (ushort *)0x0);
      local_1b4 = (float *)(float)*(int *)local_198;
      iVar11 = iVar23;
      if ((((*local_188 <= (float)local_1b4) &&
           ((float)*local_17c < *local_188 != ((float)*local_17c == *local_188))) &&
          (*(float *)(param_3 + 0xa50) <= (float)*local_19c)) &&
         ((float)*local_174 < *(float *)(param_3 + 0xa50) !=
          ((float)*local_174 == *(float *)(param_3 + 0xa50)))) {
        local_128[iVar23 * 3] = *local_188;
        iVar11 = iVar23 + 1;
        local_128[iVar23 * 3 + 1] = *(float *)(param_3 + 0xa50);
      }
      if (((*(float *)(param_3 + 0xa58) < (float)local_1b4 !=
            (*(float *)(param_3 + 0xa58) == (float)local_1b4)) &&
          ((float)*local_17c < *(float *)(param_3 + 0xa58) !=
           ((float)*local_17c == *(float *)(param_3 + 0xa58)))) &&
         ((*(float *)(param_3 + 0xa5c) <= (float)*local_19c &&
          ((float)*local_174 < *(float *)(param_3 + 0xa5c) !=
           ((float)*local_174 == *(float *)(param_3 + 0xa5c)))))) {
        local_128[iVar11 * 3] = *(float *)(param_3 + 0xa58);
        local_128[iVar11 * 3 + 1] = *(float *)(param_3 + 0xa5c);
        iVar11 = iVar11 + 1;
      }
      iVar23 = iVar11;
      if (((*(float *)(param_3 + 0xa64) < (float)local_1b4 !=
            (*(float *)(param_3 + 0xa64) == (float)local_1b4)) &&
          ((float)*local_17c < *(float *)(param_3 + 0xa64) !=
           ((float)*local_17c == *(float *)(param_3 + 0xa64)))) &&
         ((*(float *)(param_3 + 0xa68) <= (float)*local_19c &&
          ((float)*local_174 < *(float *)(param_3 + 0xa68) !=
           ((float)*local_174 == *(float *)(param_3 + 0xa68)))))) {
        local_128[iVar11 * 3] = *(float *)(param_3 + 0xa64);
        iVar23 = iVar11 + 1;
        local_128[iVar11 * 3 + 1] = *(float *)(param_3 + 0xa68);
      }
      iVar11 = iVar23;
      if ((((*(float *)(param_3 + 0xa70) < (float)local_1b4 !=
             (*(float *)(param_3 + 0xa70) == (float)local_1b4)) &&
           ((float)*local_17c < *(float *)(param_3 + 0xa70) !=
            ((float)*local_17c == *(float *)(param_3 + 0xa70)))) &&
          (*(float *)(param_3 + 0xa74) <= (float)*local_19c)) &&
         ((float)*local_174 < *(float *)(param_3 + 0xa74) !=
          ((float)*local_174 == *(float *)(param_3 + 0xa74)))) {
        local_128[iVar23 * 3] = *(float *)(param_3 + 0xa70);
        iVar11 = iVar23 + 1;
        local_128[iVar23 * 3 + 1] = *(float *)(param_3 + 0xa74);
      }
      uVar25 = 0xfffffc19000003e7;
      uVar12 = 0xfffffc19;
      local_180 = (float *)0x3e7;
      local_178 = (float *)0xfffffc19;
      local_184 = 999;
      local_1a4 = -999;
      local_1ac = (ushort *)0x0;
      if (0 < iVar11) {
        pfVar10 = local_128 + 1;
        do {
          uVar4 = (uint)(uVar25 >> 0x20);
          uVar25 = (ulonglong)uVar4 << 0x20;
          if (pfVar10[-1] < (float)(int)local_180) {
            uVar25 = FUN_0048ca30(uVar12,uVar4);
            local_180 = (float *)uVar25;
            uVar12 = extraout_ECX_00;
          }
          uVar4 = (uint)(uVar25 >> 0x20);
          uVar25 = (ulonglong)uVar4 << 0x20;
          if ((float)(int)local_178 < pfVar10[-1]) {
            uVar25 = FUN_0048ca30(uVar12,uVar4);
            local_178 = (float *)uVar25;
            uVar12 = extraout_ECX_01;
          }
          uVar4 = (uint)(uVar25 >> 0x20);
          uVar25 = (ulonglong)uVar4 << 0x20;
          if (*pfVar10 < (float)(int)local_184) {
            uVar25 = FUN_0048ca30(uVar12,uVar4);
            local_184 = (uint)uVar25;
            uVar12 = extraout_ECX_02;
          }
          uVar4 = (uint)(uVar25 >> 0x20);
          uVar25 = (ulonglong)uVar4 << 0x20;
          if ((float)(int)local_1a4 < *pfVar10) {
            uVar25 = FUN_0048ca30(uVar12,uVar4);
            local_1a4 = (uint)uVar25;
            uVar12 = extraout_ECX_03;
          }
          pfVar10 = pfVar10 + 3;
          iVar11 = iVar11 + -1;
        } while (iVar11 != 0);
        if ((int)local_180 < 0) {
          local_180 = (float *)0x0;
        }
        if ((int)local_184 < 0) {
          local_184 = 0;
        }
      }
      piVar7 = local_19c;
      pfVar10 = local_178;
      if ((int)local_1bc <= (int)local_178) {
        pfVar10 = (float *)((int)local_1bc + -1);
      }
      uVar4 = local_1a4;
      if ((int)local_1a0 <= (int)local_1a4) {
        uVar4 = (int)local_1a0 + -1;
      }
      fVar1 = (float)(int)local_180;
      *(int *)(param_3 + 0x9ec) = (int)pfVar10 - (int)local_180;
      iVar23 = uVar4 - local_184;
      *(int *)(param_3 + 0x9f0) = iVar23;
      local_16c = local_16c + (int)local_180;
      local_1a8 = (int *)((int)local_1a8 + local_184);
      *local_17c = 0;
      *local_174 = 0;
      *(int *)local_198 = (int)pfVar10 - (int)local_180;
      *local_19c = iVar23;
      *(float *)(param_3 + 0xa1c) = *(float *)(param_3 + 0xa1c) - fVar1;
      fVar15 = (float)(int)local_184;
      *(float *)(param_3 + 0xa20) = *(float *)(param_3 + 0xa20) - fVar15;
      *local_188 = *local_188 - fVar1;
      *(float *)(param_3 + 0xa50) = *(float *)(param_3 + 0xa50) - fVar15;
      *(float *)(param_3 + 0xa28) = *(float *)(param_3 + 0xa28) - fVar1;
      *(float *)(param_3 + 0xa2c) = *(float *)(param_3 + 0xa2c) - fVar15;
      *(float *)(param_3 + 0xa58) = *(float *)(param_3 + 0xa58) - fVar1;
      *(float *)(param_3 + 0xa5c) = *(float *)(param_3 + 0xa5c) - fVar15;
      *(float *)(param_3 + 0xa34) = *(float *)(param_3 + 0xa34) - fVar1;
      *(float *)(param_3 + 0xa38) = *(float *)(param_3 + 0xa38) - fVar15;
      *(float *)(param_3 + 0xa64) = *(float *)(param_3 + 0xa64) - fVar1;
      *(float *)(param_3 + 0xa68) = *(float *)(param_3 + 0xa68) - fVar15;
      *(float *)(param_3 + 0xa40) = *(float *)(param_3 + 0xa40) - fVar1;
      *(float *)(param_3 + 0xa44) = *(float *)(param_3 + 0xa44) - fVar15;
      *(float *)(param_3 + 0xa70) = *(float *)(param_3 + 0xa70) - fVar1;
      *(float *)(param_3 + 0xa74) = *(float *)(param_3 + 0xa74) - fVar15;
      iVar11 = local_16c;
      if ((float)local_16c < 128.0) {
        iVar11 = 0x80;
      }
      if ((float)(int)local_1a8 < 16.0) {
        local_1a8 = (int *)0x10;
      }
      local_1b4 = *(float **)local_198;
      local_1bc = (int *)((int)local_1b4 + iVar11);
      uVar25 = CONCAT44(local_1bc,iVar11);
      if (512.0 <= (float)(int)local_1bc) {
        uVar25 = FUN_0048ca30(iVar23,local_1bc);
        iVar23 = extraout_ECX_04;
      }
      local_1b4 = (float *)*piVar7;
      local_1bc = (int *)((int)local_1b4 + (int)local_1a8);
      dVar2 = (double)(int)local_1bc;
      if (!NAN(dVar2) && 464.0 < dVar2 != (dVar2 == 464.0)) {
        uVar26 = FUN_0048ca30(iVar23,(int)(uVar25 >> 0x20));
        local_1a8 = (int *)uVar26;
      }
      iVar23 = *local_19c;
      iVar11 = *local_17c;
      iVar13 = *local_174;
      local_1a0 = (float *)(*(int *)local_198 - iVar11);
      local_168 = (float *)((int)local_1a8 + iVar13);
      local_1b4 = (float *)(iVar11 + (int)uVar25);
      local_1bc = *(int **)(param_3 + 0xa84);
      uVar4 = 0;
      piVar7 = DAT_004d0cb4;
      do {
        if (*piVar7 < 0) {
          piVar7 = DAT_004d0cb4 + uVar4 * 10;
          piVar7[1] = (int)local_1bc;
          piVar7[2] = (int)local_1b4;
          piVar7[3] = (int)local_168;
          *piVar7 = 0x1e;
          piVar7[4] = (int)local_1a0;
          piVar7[5] = iVar23 - iVar13;
          piVar7[6] = iVar11;
          piVar7[7] = iVar13;
          piVar7[8] = (int)local_1a0;
          piVar7[9] = iVar23 - iVar13;
          break;
        }
        uVar4 = uVar4 + 1;
        piVar7 = piVar7 + 10;
      } while (uVar4 < 4);
      DAT_004d17ec = 99;
      *(uint *)(DAT_004b6898 + 0x60) = *(uint *)(DAT_004b6898 + 0x60) | 0x80;
      *(uint *)(param_3 + 0xa3ec) = *(uint *)(param_3 + 0xa3ec) & 0xfffffffd;
    }
    param_2 = DAT_004b6780;
    *(uint *)(DAT_004b6898 + 0x60) = *(uint *)(DAT_004b6898 + 0x60) & 0xfffffffe | 2;
    iVar23 = param_2[5];
    if (iVar23 != 0) {
      for (puVar6 = (undefined4 *)DAT_004d0cb4[0x2235b0]; puVar6 != (undefined4 *)0x0;
          puVar6 = (undefined4 *)puVar6[1]) {
        piVar7 = (int *)*puVar6;
        if (*piVar7 == iVar23) goto LAB_0043145d;
      }
      for (puVar6 = (undefined4 *)DAT_004d0cb4[0x2235b2]; puVar6 != (undefined4 *)0x0;
          puVar6 = (undefined4 *)puVar6[1]) {
        piVar7 = (int *)*puVar6;
        if (*piVar7 == iVar23) goto LAB_0043145d;
      }
    }
    goto LAB_00431485;
  }
  if (iVar23 == 2) {
    local_1a0 = (float *)(param_3 + 0x9e0);
    local_194 = *(float *)(param_3 + 0x9e0) + 128.0 + 192.0;
    local_190 = *(float *)(param_3 + 0x9e4) + 16.0;
    local_18c = *(float *)(param_3 + 0x9e8);
    uVar12 = *(undefined4 *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4);
    piVar7 = (int *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4);
    piVar5 = FUN_00460b50(uVar12,(int)DAT_004d0cb4,uVar12);
    if (piVar5 == (int *)0x0) {
      *piVar7 = 0;
    }
    else {
      FUN_00460c90(this,*piVar7);
    }
    puVar6 = FUN_004358a0(&local_1bc);
    *(undefined4 *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4) = *puVar6;
    piVar7 = FUN_00460b50(*(int *)(param_3 + 0xa84),(int)DAT_004d0cb4,
                          *(int *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4));
    puVar19 = (ushort *)(param_3 + 0x9ec);
    local_1ac = (ushort *)(param_3 + 0x9f0);
    *(float *)(piVar7[0xff] + 0x2c) = (float)*(int *)(param_3 + 0x9ec) * 0.001953125;
    local_1bc = (int *)((float)*(int *)local_1ac * 0.001953125);
    *(int **)(piVar7[0xff] + 0x30) = local_1bc;
    iVar23 = *(int *)puVar19;
    piVar7[0x121] = piVar7[0x121] | 8;
    piVar7[0x18] = (int)(float)iVar23;
    iVar23 = *(int *)local_1ac;
    piVar7[0x121] = piVar7[0x121] | 8;
    piVar7[0x19] = (int)(float)iVar23;
    local_198 = puVar19;
    FUN_0042fef0((int)piVar7);
    FUN_00460ce0(this_00,*(int *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4));
    FUN_00460f90();
    FUN_00460f90();
    pfVar10 = local_1a0;
    if ((*(byte *)(param_3 + 0xa3ec) & 2) == 0) {
      local_194 = (float)*(int *)(param_3 + 0x9f4);
      local_190 = (float)*(int *)(param_3 + 0x9f8);
      local_18c = 0.0;
      FUN_004205a0();
      FUN_00412660(pfVar10,&local_194,*(undefined4 *)(param_3 + 0xa80));
      FUN_00410ad0(DAT_004b678c);
      FUN_00451720(4,0xf,1,0xc0ffafcf);
      iVar23 = *(int *)(param_3 + 0xa84) * 0xec;
      if ((*(byte *)(iVar23 + 0xab0 + param_3) & 1) != 0) {
        FUN_0041a760(*(int *)(iVar23 + param_3 + 0xb20));
      }
      if (*(int *)(DAT_004b6898 + 0x74) == 0) {
        iVar23 = FUN_0041d000();
        puVar8 = (uint *)(iVar23 + 0x20);
        if (*puVar8 < 999999) {
          *puVar8 = *puVar8 + 1;
        }
        __time64((__time64_t *)(*(int *)(param_3 + 0xa84) * 0xec + 0xaa4 + param_3));
        iVar23 = FUN_0042b7a0();
        fVar24 = FUN_00430340();
        *(float *)(iVar23 + 0x24) = (float)fVar24;
        *(float *)(*(int *)(param_3 + 0xa84) * 0xec + 0xaac + param_3) = *(float *)(iVar23 + 0x24);
        *(undefined4 *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa88 + param_3) = 0x32545342;
        *(ushort *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa94 + param_3) = *puVar19;
        *(ushort *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa96 + param_3) = *local_1ac;
        *(undefined2 *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa98 + param_3) =
             *(undefined2 *)(param_3 + 0x9fc);
        *(undefined2 *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa9a + param_3) =
             *(undefined2 *)(param_3 + 0xa00);
        *(short *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa9c + param_3) =
             *(short *)(param_3 + 0xa04) - *(short *)(param_3 + 0x9fc);
        *(short *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa9e + param_3) =
             *(short *)(param_3 + 0xa08) - *(short *)(param_3 + 0xa00);
        *(undefined4 *)((*(int *)(param_3 + 0xa84) + 0xc) * 0xec + param_3) =
             *(undefined4 *)(param_3 + 0xa80);
        *(ushort *)(*(int *)(param_3 + 0xa84) * 0xec + 0xaa0 + param_3) = *puVar19 >> 1;
        *(ushort *)(*(int *)(param_3 + 0xa84) * 0xec + 0xaa2 + param_3) = *local_1ac >> 1;
        iVar23 = *(int *)(param_3 + 0xa84) * 0xec;
        *(undefined4 *)(iVar23 + 0xb14 + param_3) = *(undefined4 *)(iVar23 + 0xb20 + param_3);
        iVar23 = DAT_004b68e0;
        *(short *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa8e + param_3) =
             *(short *)(DAT_004b68e0 + 4) + 1;
        *(short *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa90 + param_3) = *(short *)(iVar23 + 8) + 1;
        *(undefined1 *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa8c + param_3) = 5;
        *(undefined2 *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa92 + param_3) = 0x100;
        *(char *)(*(int *)(param_3 + 0xa84) * 0xec + 0xa8d + param_3) =
             (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                      *(int *)(param_3 + 0xa84) * 0x14) == 4) * '\x02' + '\x02';
        if (*(int *)(param_3 + 0xa84) != 10) {
          iVar23 = *(int *)(param_3 + 0xa84) * 0xec;
          if (DAT_004b6780 == (int *)0x0) {
            _memset((void *)(iVar23 + 0xb24 + param_3),0,0x50);
          }
          else {
            piVar7 = DAT_004b6780 + 0x1e;
            pcVar20 = (char *)(iVar23 + 0xb24 + param_3);
            do {
              iVar23 = *piVar7;
              *pcVar20 = (char)iVar23;
              piVar7 = (int *)((int)piVar7 + 1);
              pcVar20 = pcVar20 + 1;
            } while ((char)iVar23 != '\0');
          }
          iVar23 = FUN_0041d000();
          if (((*(byte *)(iVar23 + 0x38) & 2) == 0) &&
             (*(int *)(iVar23 + 0x3c) < *(int *)(*(int *)(param_3 + 0xa84) * 0xec + 0xb20 + param_3)
             )) {
            FUN_0042b7d0(DAT_004b68d0,DAT_004b30ac);
            iVar23 = *(int *)(param_3 + 0xa84);
            iVar11 = FUN_0041d000();
            *(undefined4 *)(iVar11 + 0x3c) = *(undefined4 *)(iVar23 * 0xec + 0xb20 + param_3);
            iVar23 = FUN_0042b7a0();
            *(undefined1 *)(iVar23 + 0xe4) = 1;
            iVar23 = *(int *)(param_3 + 0xa84);
            puVar9 = (undefined4 *)FUN_0042b7a0();
            puVar6 = (undefined4 *)(iVar23 * 0xec + 0xa88 + param_3);
            for (iVar11 = 0x25; iVar11 != 0; iVar11 = iVar11 + -1) {
              *puVar9 = *puVar6;
              puVar6 = puVar6 + 1;
              puVar9 = puVar9 + 1;
            }
            iVar11 = *(int *)(param_3 + 0xa84) * 0xec;
            iVar23 = FUN_0041d000();
            *(undefined4 *)(iVar23 + 0x2c) = *(undefined4 *)(iVar11 + 0xaa4 + param_3);
            *(undefined4 *)(iVar23 + 0x30) = *(undefined4 *)(iVar11 + 0xaa8 + param_3);
            if (DAT_004b6780 == (int *)0x0) {
              _Size = 0x50;
              iVar11 = 0;
              iVar23 = FUN_0042b7a0();
              _memset((void *)(iVar23 + 0x94),iVar11,_Size);
            }
            else {
              piVar7 = DAT_004b6780 + 0x1e;
              iVar23 = FUN_0042b7a0();
              pcVar20 = (char *)(iVar23 + 0x94);
              do {
                iVar23 = *piVar7;
                *pcVar20 = (char)iVar23;
                piVar7 = (int *)((int)piVar7 + 1);
                pcVar20 = pcVar20 + 1;
              } while ((char)iVar23 != '\0');
            }
            iVar23 = *(int *)(param_3 + 0xa84);
            iVar11 = FUN_0042b7a0();
            if (iVar23 == 10) {
              *(undefined4 *)(iVar11 + 0xe8) = 0xffffffff;
              FUN_00433a50(param_3);
              puVar19 = local_198;
            }
            else {
              *(int *)(iVar11 + 0xe8) = iVar23;
              puVar19 = local_198;
            }
          }
        }
      }
    }
    local_19c = (int *)0x0;
    piVar7 = *(int **)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) +
                      *(int *)(param_3 + 0xa84) * 0x14);
    piVar5 = (int *)0x0;
    (**(code **)(*piVar7 + 0x48))();
    iVar23 = 0;
    (**(code **)(*local_1a8 + 0x34))(local_1a8,&stack0xfffffe40);
    (**(code **)(*piStack_1b8 + 0x30))(piStack_1b8,&local_180);
    if ((ABS(*(float *)(param_3 + 0xa28) - *(float *)(param_3 + 0xa1c)) < 0.5) ||
       (ABS(*(float *)(param_3 + 0xa2c) - *(float *)(param_3 + 0xa20)) < 0.5)) {
      if ((*(int *)(param_3 + 0xa10) == 0) ||
         (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                  *(int *)(param_3 + 0xa84) * 0x14) != 4)) {
        iVar11 = 0;
        if (*(int *)(param_3 + 0xa00) != -3 && -1 < *(int *)(param_3 + 0xa00) + 3) {
          do {
            _memset((int *)(iVar23 * iVar11 + (int)piVar7),0xfe,
                    *(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                            *(int *)(param_3 + 0xa84) * 0x14) * *(int *)puVar19);
            iVar11 = iVar11 + 1;
          } while (iVar11 < *(int *)(param_3 + 0xa00) + 3);
        }
      }
      else {
        iVar11 = *(int *)(param_3 + 0xa00);
        bVar14 = 0;
        if (iVar11 < iVar11 + 0xc) {
          do {
            iVar13 = *(int *)(param_3 + 0x9fc);
            bVar14 = bVar14 + 0x13;
            if (iVar13 < *(int *)(param_3 + 0xa04)) {
              pbVar21 = (byte *)((int)piVar7 + iVar13 * 4 + iVar23 * iVar11 + 3);
              do {
                if (*pbVar21 != 0) {
                  *pbVar21 = (byte)(((uint)*pbVar21 * (uint)bVar14) / 0xff);
                }
                iVar13 = iVar13 + 1;
                pbVar21 = pbVar21 + 4;
              } while (iVar13 < *(int *)(param_3 + 0xa04));
            }
            iVar11 = iVar11 + 1;
          } while (iVar11 < *(int *)(param_3 + 0xa00) + 0xc);
        }
      }
      piVar3 = local_1bc;
      if ((*(int *)(param_3 + 0xa18) == 0) ||
         (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                  *(int *)(param_3 + 0xa84) * 0x14) != 4)) {
        iVar11 = *piVar5 + -1;
        if (*(int *)(param_3 + 0xa08) + -3 <= iVar11) {
          do {
            _memset((int *)(iVar23 * iVar11 + (int)piVar7),0xfe,
                    *(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                            *(int *)(param_3 + 0xa84) * 0x14) * *piVar3);
            iVar11 = iVar11 + -1;
          } while (*(int *)(param_3 + 0xa08) + -3 <= iVar11);
        }
      }
      else {
        iVar11 = *(int *)(param_3 + 0xa08) + -1;
        bVar14 = 0;
        if (*(int *)(param_3 + 0xa08) + -0xc <= iVar11) {
          do {
            iVar13 = *(int *)(param_3 + 0x9fc);
            bVar14 = bVar14 + 0x13;
            if (iVar13 < *(int *)(param_3 + 0xa04)) {
              pbVar21 = (byte *)((int)piVar7 + iVar13 * 4 + iVar23 * iVar11 + 3);
              do {
                if (*pbVar21 != 0) {
                  *pbVar21 = (byte)(((uint)*pbVar21 * (uint)bVar14) / 0xff);
                }
                iVar13 = iVar13 + 1;
                pbVar21 = pbVar21 + 4;
              } while (iVar13 < *(int *)(param_3 + 0xa04));
            }
            iVar11 = iVar11 + -1;
          } while (*(int *)(param_3 + 0xa08) + -0xc <= iVar11);
        }
      }
      iVar11 = *(int *)(param_3 + 0xa00);
      if (iVar11 < *(int *)(param_3 + 0xa08)) {
        do {
          piVar5 = (int *)((int)piVar7 + iVar23 * iVar11);
          if ((*(int *)(param_3 + 0xa0c) == 0) ||
             (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                      *(int *)(param_3 + 0xa84) * 0x14) != 4)) {
            iVar13 = *(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                             *(int *)(param_3 + 0xa84) * 0x14);
            _memset((int *)(*(int *)(param_3 + 0x9fc) * iVar13 + (int)piVar5),0xfe,iVar13 * 3);
          }
          else {
            uVar4 = 0;
            pbVar21 = (byte *)((int)piVar7 + iVar23 * iVar11 + *(int *)(param_3 + 0x9fc) * 4 + 7);
            iVar13 = 2;
            do {
              cVar16 = (char)uVar4;
              if (pbVar21[-4] != 0) {
                pbVar21[-4] = (byte)(((uint)pbVar21[-4] * (uint)(byte)(cVar16 + 0x13)) / 0xff);
              }
              if (*pbVar21 != 0) {
                *pbVar21 = (byte)(((uint)*pbVar21 * (uint)(byte)(cVar16 + 0x26)) / 0xff);
              }
              if (pbVar21[4] != 0) {
                pbVar21[4] = (byte)(((uint)pbVar21[4] * (uint)(byte)(cVar16 + 0x39)) / 0xff);
              }
              if (pbVar21[8] != 0) {
                pbVar21[8] = (byte)(((uint)pbVar21[8] * (uint)(byte)(cVar16 + 0x4c)) / 0xff);
              }
              if (pbVar21[0xc] != 0) {
                pbVar21[0xc] = (byte)(((uint)pbVar21[0xc] * (uint)(byte)(cVar16 + 0x5f)) / 0xff);
              }
              uVar4 = (uint)(byte)(cVar16 + 0x72);
              if (pbVar21[0x10] != 0) {
                pbVar21[0x10] = (byte)((pbVar21[0x10] * uVar4) / 0xff);
              }
              pbVar21 = pbVar21 + 0x18;
              iVar13 = iVar13 + -1;
            } while (iVar13 != 0);
          }
          if ((*(int *)(param_3 + 0xa14) == 0) ||
             (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                      *(int *)(param_3 + 0xa84) * 0x14) != 4)) {
            iVar13 = *(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                             *(int *)(param_3 + 0xa84) * 0x14);
            _memset((int *)((*(int *)(param_3 + 0xa04) + -3) * iVar13 + (int)piVar5),0xfe,iVar13 * 3
                   );
          }
          else {
            uVar4 = 0;
            pbVar21 = (byte *)((int)piVar7 + *(int *)(param_3 + 0xa04) * 4 + iVar23 * iVar11 + -5);
            iVar13 = 2;
            do {
              cVar16 = (char)uVar4;
              if (pbVar21[4] != 0) {
                pbVar21[4] = (byte)(((uint)pbVar21[4] * (uint)(byte)(cVar16 + 0x13)) / 0xff);
              }
              if (*pbVar21 != 0) {
                *pbVar21 = (byte)(((uint)*pbVar21 * (uint)(byte)(cVar16 + 0x26)) / 0xff);
              }
              if (pbVar21[-4] != 0) {
                pbVar21[-4] = (byte)(((uint)pbVar21[-4] * (uint)(byte)(cVar16 + 0x39)) / 0xff);
              }
              if (pbVar21[-8] != 0) {
                pbVar21[-8] = (byte)(((uint)pbVar21[-8] * (uint)(byte)(cVar16 + 0x4c)) / 0xff);
              }
              if (pbVar21[-0xc] != 0) {
                pbVar21[-0xc] = (byte)(((uint)pbVar21[-0xc] * (uint)(byte)(cVar16 + 0x5f)) / 0xff);
              }
              uVar4 = (uint)(byte)(cVar16 + 0x72);
              if (pbVar21[-0x10] != 0) {
                pbVar21[-0x10] = (byte)((pbVar21[-0x10] * uVar4) / 0xff);
              }
              pbVar21 = pbVar21 + -0x18;
              iVar13 = iVar13 + -1;
            } while (iVar13 != 0);
          }
          iVar11 = iVar11 + 1;
        } while (iVar11 < *(int *)(param_3 + 0xa08));
      }
    }
    else {
      FUN_00432ab0(param_3 + 0xa28,(float *)(param_3 + 0xa1c),(float *)(param_3 + 0xa28),
                   (float *)(param_3 + 0xa34),0xfe,(int *)&stack0xfffffe28);
      FUN_00432ab0(param_3 + 0xa40,(float *)(param_3 + 0xa1c),(float *)(param_3 + 0xa40),
                   (float *)(param_3 + 0xa34),0xfe,(int *)&stack0xfffffe28);
      if ((*(int *)(param_3 + 0xa10) != 0) &&
         (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                  *(int *)(param_3 + 0xa84) * 0x14) == 4)) {
        iVar11 = *(int *)(param_3 + 0xa00);
        bVar14 = 0;
        if (iVar11 < iVar11 + 0xc) {
          do {
            iVar13 = *(int *)(param_3 + 0x9fc);
            bVar14 = bVar14 + 0x13;
            if (iVar13 < *(int *)(param_3 + 0xa04)) {
              pbVar21 = (byte *)((int)piVar7 + iVar13 * 4 + iVar23 * iVar11 + 3);
              do {
                if (*pbVar21 != 0) {
                  *pbVar21 = (byte)(((uint)bVar14 * (uint)*pbVar21) / 0xff);
                }
                iVar13 = iVar13 + 1;
                pbVar21 = pbVar21 + 4;
              } while (iVar13 < *(int *)(param_3 + 0xa04));
            }
            iVar11 = iVar11 + 1;
          } while (iVar11 < *(int *)(param_3 + 0xa00) + 0xc);
        }
      }
      if ((*(int *)(param_3 + 0xa18) != 0) &&
         (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                  *(int *)(param_3 + 0xa84) * 0x14) == 4)) {
        iVar11 = *(int *)(param_3 + 0xa08) + -1;
        bVar14 = 0;
        if (*(int *)(param_3 + 0xa08) + -0xc <= iVar11) {
          do {
            iVar13 = *(int *)(param_3 + 0x9fc);
            bVar14 = bVar14 + 0x13;
            if (iVar13 < *(int *)(param_3 + 0xa04)) {
              pbVar21 = (byte *)((int)piVar7 + iVar13 * 4 + iVar23 * iVar11 + 3);
              do {
                if (*pbVar21 != 0) {
                  *pbVar21 = (byte)(((uint)bVar14 * (uint)*pbVar21) / 0xff);
                }
                iVar13 = iVar13 + 1;
                pbVar21 = pbVar21 + 4;
              } while (iVar13 < *(int *)(param_3 + 0xa04));
            }
            iVar11 = iVar11 + -1;
          } while (*(int *)(param_3 + 0xa08) + -0xc <= iVar11);
        }
      }
      iVar11 = *(int *)(param_3 + 0xa00);
      if (iVar11 < *(int *)(param_3 + 0xa08)) {
        do {
          if ((*(int *)(param_3 + 0xa0c) != 0) &&
             (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                      *(int *)(param_3 + 0xa84) * 0x14) == 4)) {
            uVar4 = 0;
            pbVar21 = (byte *)((int)piVar7 + *(int *)(param_3 + 0x9fc) * 4 + iVar23 * iVar11 + 7);
            iVar13 = 2;
            do {
              cVar16 = (char)uVar4;
              if (pbVar21[-4] != 0) {
                pbVar21[-4] = (byte)(((uint)(byte)(cVar16 + 0x13) * (uint)pbVar21[-4]) / 0xff);
              }
              if (*pbVar21 != 0) {
                *pbVar21 = (byte)(((uint)(byte)(cVar16 + 0x26) * (uint)*pbVar21) / 0xff);
              }
              if (pbVar21[4] != 0) {
                pbVar21[4] = (byte)(((uint)(byte)(cVar16 + 0x39) * (uint)pbVar21[4]) / 0xff);
              }
              if (pbVar21[8] != 0) {
                pbVar21[8] = (byte)(((uint)(byte)(cVar16 + 0x4c) * (uint)pbVar21[8]) / 0xff);
              }
              if (pbVar21[0xc] != 0) {
                pbVar21[0xc] = (byte)(((uint)(byte)(cVar16 + 0x5f) * (uint)pbVar21[0xc]) / 0xff);
              }
              uVar4 = (uint)(byte)(cVar16 + 0x72);
              if (pbVar21[0x10] != 0) {
                pbVar21[0x10] = (byte)((uVar4 * pbVar21[0x10]) / 0xff);
              }
              pbVar21 = pbVar21 + 0x18;
              iVar13 = iVar13 + -1;
            } while (iVar13 != 0);
          }
          if ((*(int *)(param_3 + 0xa14) != 0) &&
             (*(int *)(*(int *)(*(int *)(param_3 + 0xa3e4) + 0x120) + 0xc +
                      *(int *)(param_3 + 0xa84) * 0x14) == 4)) {
            uVar4 = 0;
            pbVar21 = (byte *)((int)piVar7 + *(int *)(param_3 + 0xa04) * 4 + iVar23 * iVar11 + -5);
            iVar13 = 2;
            do {
              cVar16 = (char)uVar4;
              if (pbVar21[4] != 0) {
                pbVar21[4] = (byte)(((uint)(byte)(cVar16 + 0x13) * (uint)pbVar21[4]) / 0xff);
              }
              if (*pbVar21 != 0) {
                *pbVar21 = (byte)(((uint)(byte)(cVar16 + 0x26) * (uint)*pbVar21) / 0xff);
              }
              if (pbVar21[-4] != 0) {
                pbVar21[-4] = (byte)(((uint)(byte)(cVar16 + 0x39) * (uint)pbVar21[-4]) / 0xff);
              }
              if (pbVar21[-8] != 0) {
                pbVar21[-8] = (byte)(((uint)(byte)(cVar16 + 0x4c) * (uint)pbVar21[-8]) / 0xff);
              }
              if (pbVar21[-0xc] != 0) {
                pbVar21[-0xc] = (byte)(((uint)(byte)(cVar16 + 0x5f) * (uint)pbVar21[-0xc]) / 0xff);
              }
              uVar4 = (uint)(byte)(cVar16 + 0x72);
              if (pbVar21[-0x10] != 0) {
                pbVar21[-0x10] = (byte)((uVar4 * pbVar21[-0x10]) / 0xff);
              }
              pbVar21 = pbVar21 + -0x18;
              iVar13 = iVar13 + -1;
            } while (iVar13 != 0);
          }
          iVar11 = iVar11 + 1;
        } while (iVar11 < *(int *)(param_3 + 0xa08));
      }
      FUN_00432ab0(&stack0xfffffe28,(float *)(param_3 + 0xa4c),(float *)(param_3 + 0xa58),
                   (float *)(param_3 + 0xa64),0,(int *)&stack0xfffffe28);
      FUN_00432ab0(&stack0xfffffe28,(float *)(param_3 + 0xa4c),(float *)(param_3 + 0xa70),
                   (float *)(param_3 + 0xa64),0,(int *)&stack0xfffffe28);
    }
    (**(code **)(*unaff_EBX + 0x38))(unaff_EBX);
    (**(code **)(*unaff_ESI + 8))(unaff_ESI);
    param_2 = extraout_EDX_00;
  }
  else {
    param_2 = (int *)0xa;
    if (iVar23 == 10) {
      if (((uVar4 & 2) == 0) && (*(int *)(param_3 + 0xa84) != 10)) {
        FUN_00460ba0(*(void **)((int)DAT_004b68c8 + 0x3834),
                     *(int *)(param_3 + 0xc + (int)*(void **)((int)DAT_004b68c8 + 0x3834) * 4));
        param_2 = *(int **)((int)DAT_004b68c8 + 0x383c);
        piVar7 = (int *)(*(int *)((int)DAT_004b68c8 + 0x3834) + 1);
        if ((int)piVar7 <= (int)param_2) {
          local_194 = 0.0;
          local_190 = 0.0;
          local_18c = 0.0;
          if ((((*(float *)((int)DAT_004b68c8 + 0x5fc) < 284.0) &&
               (228.0 < *(float *)((int)DAT_004b68c8 + 0x5fc))) &&
              (*(float *)((int)DAT_004b68c8 + 0x5f8) < 96.0)) &&
             (-96.0 < *(float *)((int)DAT_004b68c8 + 0x5f8))) {
            local_190 = 96.0;
          }
          if (piVar7 == param_2) {
            iVar23 = 0x2e;
          }
          else {
            FUN_004607a0(*(void **)(param_3 + 0xa3e4),&local_1bc,0x2d,0x17,0);
            iVar23 = (*(int *)((int)DAT_004b68c8 + 0x383c) - *(int *)((int)DAT_004b68c8 + 0x3834)) +
                     0x2d;
          }
          FUN_004607a0(*(void **)(param_3 + 0xa3e4),&local_1bc,iVar23,0x17,0);
          param_2 = extraout_EDX_01;
        }
      }
    }
    else if (iVar23 == 0x23) {
      if (((uVar4 & 2) == 0) && (*(int *)(param_3 + 0xa84) != 10)) {
        local_1b4 = (float *)(*(int *)((int)DAT_004b68c8 + 0x3834) + -1);
        FUN_00460ba0(DAT_004b68c8,*(int *)(param_3 + 0xc + *(int *)((int)DAT_004b68c8 + 0x3834) * 4)
                    );
        uVar12 = *(undefined4 *)(param_3 + 0x14ac + *(int *)(param_3 + 0xa84) * 4);
        piVar7 = FUN_00460b50(uVar12,(int)DAT_004d0cb4,uVar12);
        local_194 = 0.0;
        local_1bc = (int *)((float)piVar7[0x19] * (float)piVar7[0x11]);
        local_190 = -(float)local_1bc * 0.6 * 0.5;
        local_18c = 0.0;
        FUN_00463bc0(extraout_ECX_05);
        pfVar10 = (float *)FUN_004357f0((int)piVar7);
        local_194 = *pfVar10 + local_194;
        local_190 = pfVar10[1] + local_190;
        local_18c = pfVar10[2] + local_18c;
        puVar6 = FUN_00435990(*(void **)(DAT_004b6794 + 0x2604),&local_1bc);
        pfVar10 = local_1b4;
        iVar23 = DAT_004b6794;
        local_190 = local_190 - 6.0;
        *(undefined4 *)(param_3 + 0x10 + (int)local_1b4 * 4) = *puVar6;
        puVar6 = FUN_00435990(*(void **)(iVar23 + 0x2604),&local_1bc);
        *(undefined4 *)(param_3 + 0x3c + (int)pfVar10 * 4) = *puVar6;
        param_2 = extraout_EDX_02;
      }
      *(uint *)(DAT_004b6898 + 0x60) = *(uint *)(DAT_004b6898 + 0x60) & 0xfffffffd;
      *(uint *)(param_3 + 0xa3ec) = *(uint *)(param_3 + 0xa3ec) & 0xfffffffe;
    }
  }
  goto LAB_00432490;
LAB_0043145d:
  if ((piVar7 != (int *)0x0) && (piVar7[0x121] = piVar7[0x121] & 0xfffffffd, piVar7[6] == 0)) {
    for (piVar7 = (int *)piVar7[5]; piVar7 != (int *)0x0; piVar7 = (int *)piVar7[1]) {
      *(uint *)(*piVar7 + 0x484) = *(uint *)(*piVar7 + 0x484) & 0xfffffffd;
    }
  }
LAB_00431485:
  iVar23 = param_2[6];
  if (iVar23 != 0) {
    for (puVar6 = (undefined4 *)DAT_004d0cb4[0x2235b0]; puVar6 != (undefined4 *)0x0;
        puVar6 = (undefined4 *)puVar6[1]) {
      piVar7 = (int *)*puVar6;
      param_2 = DAT_004d0cb4;
      if (*piVar7 == iVar23) goto LAB_004314d1;
    }
    param_2 = DAT_004d0cb4;
    for (puVar6 = (undefined4 *)DAT_004d0cb4[0x2235b2]; puVar6 != (undefined4 *)0x0;
        puVar6 = (undefined4 *)puVar6[1]) {
      piVar7 = (int *)*puVar6;
      param_2 = piVar7;
      if (*piVar7 == iVar23) goto LAB_004314d1;
    }
  }
  goto LAB_00432490;
LAB_004314d1:
  if (((piVar7 != (int *)0x0) && (piVar7[0x121] = piVar7[0x121] & 0xfffffffd, piVar7[6] == 0)) &&
     (piVar7 = (int *)piVar7[5], piVar7 != (int *)0x0)) {
    param_2 = (int *)0xfffffffd;
    do {
      *(uint *)(*piVar7 + 0x484) = *(uint *)(*piVar7 + 0x484) & 0xfffffffd;
      piVar7 = (int *)piVar7[1];
    } while (piVar7 != (int *)0x0);
  }
LAB_00432490:
  pvVar22 = DAT_004b68c8;
  *(int *)(param_3 + 0xa3f0) = *(int *)(param_3 + 0xa3f0) + 1;
  if (*(int *)(param_3 + 0xa3f0) == 2) {
    *(uint *)(param_3 + 0xa3ec) = *(uint *)(param_3 + 0xa3ec) | 4;
  }
  else {
    *(uint *)(param_3 + 0xa3ec) = *(uint *)(param_3 + 0xa3ec) & 0xfffffffb;
  }
LAB_00432702:
  iVar23 = DAT_004b6770;
  if (*(int *)(param_3 + 0xa3d0) != 0) {
    local_1a0 = (float *)0x0;
    if (0 < *(int *)(param_3 + 0xa3d0)) {
      local_198 = (ushort *)(param_3 + 0x151c);
      local_17c = (int *)(param_3 + 0xa358);
      do {
        iVar11 = 0;
        if (0 < *(int *)(iVar23 + 0x1c7f0)) {
          piVar7 = (int *)(iVar23 + 0xa8c);
          do {
            if (*local_17c == *piVar7) {
              iVar11 = iVar11 * 0x164 + 0x98c + iVar23;
              goto LAB_0043276b;
            }
            iVar11 = iVar11 + 1;
            piVar7 = piVar7 + 0x59;
          } while (iVar11 < *(int *)(iVar23 + 0x1c7f0));
        }
        iVar11 = iVar23 + 0x1c68c;
LAB_0043276b:
        *(undefined1 *)(iVar11 + 0x113) = *(undefined1 *)((int)local_198 + 899);
        iVar11 = 0;
        if (0 < *(int *)(iVar23 + 0x1c7f0)) {
          piVar7 = (int *)(iVar23 + 0xa8c);
          do {
            if (*local_17c == *piVar7) {
              iVar11 = iVar11 * 0x164 + 0x98c + iVar23;
              goto LAB_004327ae;
            }
            iVar11 = iVar11 + 1;
            piVar7 = piVar7 + 0x59;
          } while (iVar11 < *(int *)(iVar23 + 0x1c7f0));
        }
        iVar11 = iVar23 + 0x1c68c;
LAB_004327ae:
        local_17c = local_17c + 1;
        *(int *)(iVar11 + 0x120) = *(int *)local_198;
        local_1a0 = (float *)((int)local_1a0 + 1);
        local_198 = local_198 + 0x25e;
        pvVar22 = DAT_004b68c8;
      } while ((int)local_1a0 < *(int *)(param_3 + 0xa3d0));
    }
    fVar15 = 0.0;
    uVar4 = *(uint *)(param_3 + 0xa3ec);
    fVar1 = *(float *)(param_3 + 0xa3d8) + 32.0;
    if ((uVar4 & 8) == 0) {
      if ((*(float *)((int)pvVar22 + 0x5fc) < fVar1) &&
         (((*(float *)(param_3 + 0xa3d4) < 320.0 && (*(float *)((int)pvVar22 + 0x5f8) < 0.0)) ||
          ((320.0 < *(float *)(param_3 + 0xa3d4) != (*(float *)(param_3 + 0xa3d4) == 320.0) &&
           (fVar1 = *(float *)((int)pvVar22 + 0x5f8), !NAN(fVar1) && 0.0 < fVar1 != (fVar1 == 0.0)))
          )))) {
        iVar23 = 0;
        *(uint *)(param_3 + 0xa3ec) = uVar4 | 8;
        if (0 < *(int *)(param_3 + 0xa3d0)) {
          puVar8 = (uint *)(param_3 + 0x1634);
          do {
            if (puVar8[0xb3] != 0) {
              puVar8[1] = 0x10;
              puVar8[-6] = 0;
              puVar8[-5] = 0;
              puVar8[2] = 0;
              puVar8[-8] = (uint)*(byte *)((int)puVar8 + 0x26b);
              puVar8[-7] = 0x20;
              if ((*puVar8 & 1) == 0) {
                puVar8[-2] = 0;
                puVar8[-3] = 0;
                puVar8[-4] = 0xfff0bdc1;
                puVar8[-1] = (uint)&DAT_004b5308;
                *puVar8 = *puVar8 | 1;
              }
              puVar8[-2] = 0;
              puVar8[-3] = 0;
              puVar8[-4] = 0xffffffff;
            }
            iVar23 = iVar23 + 1;
            puVar8 = puVar8 + 0x12f;
          } while (iVar23 < *(int *)(param_3 + 0xa3d0));
        }
      }
    }
    else if ((fVar1 <= *(float *)((int)pvVar22 + 0x5fc)) ||
            (((320.0 <= *(float *)(param_3 + 0xa3d4) || (0.0 <= *(float *)((int)pvVar22 + 0x5f8)))
             && ((320.0 < *(float *)(param_3 + 0xa3d4) == (*(float *)(param_3 + 0xa3d4) == 320.0) ||
                 (fVar1 = *(float *)((int)pvVar22 + 0x5f8),
                 NAN(fVar1) || 0.0 < fVar1 == (fVar1 == 0.0))))))) {
      iVar23 = 0;
      *(uint *)(param_3 + 0xa3ec) = uVar4 & 0xfffffff7;
      if (0 < *(int *)(param_3 + 0xa3d0)) {
        puVar8 = (uint *)(param_3 + 0x1634);
        do {
          if (puVar8[0xb3] != 0) {
            puVar8[1] = 0x10;
            puVar8[-6] = 0;
            puVar8[-5] = 0;
            puVar8[2] = 0;
            puVar8[-8] = (uint)*(byte *)((int)puVar8 + 0x26b);
            puVar8[-7] = 0xff;
            if ((*puVar8 & 1) == 0) {
              puVar8[-2] = 0;
              puVar8[-3] = 0;
              puVar8[-4] = 0xfff0bdc1;
              puVar8[-1] = (uint)&DAT_004b5308;
              *puVar8 = *puVar8 | 1;
            }
            puVar8[-2] = 0;
            puVar8[-3] = 0;
            puVar8[-4] = 0xffffffff;
          }
          iVar23 = iVar23 + 1;
          puVar8 = puVar8 + 0x12f;
        } while (iVar23 < *(int *)(param_3 + 0xa3d0));
      }
    }
    iVar23 = 0;
    if (0 < *(int *)(param_3 + 0xa3d0)) {
      iVar11 = param_3 + 0x14d8;
      do {
        lVar27 = FUN_00454430(iVar11,fVar15);
        fVar15 = (float)((ulonglong)lVar27 >> 0x20);
        iVar23 = iVar23 + 1;
        iVar11 = iVar11 + 0x4bc;
      } while (iVar23 < *(int *)(param_3 + 0xa3d0));
    }
    param_2 = (int *)(*(int *)(param_3 + 0xa3d0) * 0x4bc);
    if ((*(byte *)((int)param_2 + param_3 + 0x14a0) & 1) == 0) {
      *(undefined4 *)(param_3 + 0xa3d0) = 0;
    }
  }
  lVar27 = FUN_00454430(param_3 + 0x68,(float)param_2);
  lVar27 = FUN_00454430(param_3 + 0x524,(float)((ulonglong)lVar27 >> 0x20));
  return CONCAT44((int)((ulonglong)lVar27 >> 0x20),1);
}



