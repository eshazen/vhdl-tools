-- -------------------------------------------------------------------------------------------------
-- Auto-generated from:
-- https://docs.google.com/spreadsheets/d/1oJh-NPv990n6AzXXZ7cBaySrltqBO-eGucrsnOx_r4s
-- -------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library l0mdt_lib;
use l0mdt_lib.mdttp_constants_pkg.all;
use l0mdt_lib.mdttp_types_pkg.all;

package mdttp_functions_pkg is

  constant DF_HASH : std_logic_vector(31 downto 0);

  -- -----------------------------------------------------------------
  function slc_muid_2af (d: SLC_MUID_rt)
  return std_logic_vector;

  function slc_muid_2rf (v: slc_muid_at)
  return SLC_MUID_rt;

  -- -----------------------------------------------------------------
  function slc_common_2af (d: SLC_COMMON_rt)
  return std_logic_vector;

  function slc_common_2rf (v: slc_common_at)
  return SLC_COMMON_rt;

  -- -----------------------------------------------------------------
  function slc_endcap_2af (d: SLC_ENDCAP_rt)
  return std_logic_vector;

  function slc_endcap_2rf (v: slc_endcap_at)
  return SLC_ENDCAP_rt;

  -- -----------------------------------------------------------------
  function slc_barrel_2af (d: SLC_BARREL_rt)
  return std_logic_vector;

  function slc_barrel_2rf (v: slc_barrel_at)
  return SLC_BARREL_rt;

  -- -----------------------------------------------------------------
  function slcproc_pipe_common_2af (d: SLCPROC_PIPE_COMMON_rt)
  return std_logic_vector;

  function slcproc_pipe_common_2rf (v: slcproc_pipe_common_at)
  return SLCPROC_PIPE_COMMON_rt;

  -- -----------------------------------------------------------------
  function slcproc_pipe_endcap_2af (d: SLCPROC_PIPE_ENDCAP_rt)
  return std_logic_vector;

  function slcproc_pipe_endcap_2rf (v: slcproc_pipe_endcap_at)
  return SLCPROC_PIPE_ENDCAP_rt;

  -- -----------------------------------------------------------------
  function slcproc_pipe_barrel_2af (d: SLCPROC_PIPE_BARREL_rt)
  return std_logic_vector;

  function slcproc_pipe_barrel_2rf (v: slcproc_pipe_barrel_at)
  return SLCPROC_PIPE_BARREL_rt;

  -- -----------------------------------------------------------------
  function tdc_2af (d: TDC_rt)
  return std_logic_vector;

  function tdc_2rf (v: tdc_at)
  return TDC_rt;

  -- -----------------------------------------------------------------
  function tdcpolmux_2af (d: TDCPOLMUX_rt)
  return std_logic_vector;

  function tdcpolmux_2rf (v: tdcpolmux_at)
  return TDCPOLMUX_rt;

  -- -----------------------------------------------------------------
  function slcproc_hps_sf_2af (d: SLCPROC_HPS_SF_rt)
  return std_logic_vector;

  function slcproc_hps_sf_2rf (v: slcproc_hps_sf_at)
  return SLCPROC_HPS_SF_rt;

  -- -----------------------------------------------------------------
  function tar_2af (d: TAR_rt)
  return std_logic_vector;

  function tar_2rf (v: tar_at)
  return TAR_rt;

  -- -----------------------------------------------------------------
  function hps_lsf_2af (d: HPS_LSF_rt)
  return std_logic_vector;

  function hps_lsf_2rf (v: hps_lsf_at)
  return HPS_LSF_rt;

  -- -----------------------------------------------------------------
  function hps_csf_2af (d: HPS_CSF_rt)
  return std_logic_vector;

  function hps_csf_2rf (v: hps_csf_at)
  return HPS_CSF_rt;

  -- -----------------------------------------------------------------
  function slcpipe_ptcalc_2af (d: SLCPIPE_PTCALC_rt)
  return std_logic_vector;

  function slcpipe_ptcalc_2rf (v: slcpipe_ptcalc_at)
  return SLCPIPE_PTCALC_rt;

  -- -----------------------------------------------------------------
  function sf_2af (d: SF_rt)
  return std_logic_vector;

  function sf_2rf (v: sf_at)
  return SF_rt;

  -- -----------------------------------------------------------------
  function ptcalc_2af (d: PTCALC_rt)
  return std_logic_vector;

  function ptcalc_2rf (v: ptcalc_at)
  return PTCALC_rt;

  -- -----------------------------------------------------------------
  function slcpipe_mtc_endcap_2af (d: SLCPIPE_MTC_ENDCAP_rt)
  return std_logic_vector;

  function slcpipe_mtc_endcap_2rf (v: slcpipe_mtc_endcap_at)
  return SLCPIPE_MTC_ENDCAP_rt;

  -- -----------------------------------------------------------------
  function slcpipe_mtc_barrel_2af (d: SLCPIPE_MTC_BARREL_rt)
  return std_logic_vector;

  function slcpipe_mtc_barrel_2rf (v: slcpipe_mtc_barrel_at)
  return SLCPIPE_MTC_BARREL_rt;

  -- -----------------------------------------------------------------
  function mtc_2af (d: MTC_rt)
  return std_logic_vector;

  function mtc_2rf (v: mtc_at)
  return MTC_rt;

  -- -------------------------------------------------------------------

end package mdttp_functions_pkg;

package body mdttp_functions_pkg is

  constant DF_HASH : std_logic_vector(31 downto 0) := x"b70475b5";

  -- -----------------------------------------------------------------
  function slc_muid_2af (d: SLC_MUID_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLC_MUID_LEN-1 downto 0);
  begin
    v := d.slcid
         & d.slid
         & d.bcid;
    return v;
  end function slc_muid_2af;

  function slc_muid_2rf (v: slc_muid_at)
  return SLC_MUID_rt is
    variable b : SLC_MUID_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLC_MUID_LEN - 1; -- 20
    lsb := msb - SLC_MUID_SLCID_LEN + 1; -- 2
    b.slcid := v(msb downto lsb); -- 19 18
    msb := lsb - 1;
    lsb := msb - SLC_MUID_SLID_LEN + 1; -- 6
    b.slid := v(msb downto lsb); -- 17 12
    msb := lsb - 1;
    lsb := msb - SLC_MUID_BCID_LEN + 1; -- 12
    b.bcid := v(msb downto lsb); -- 11 0
    return b;
  end function slc_muid_2rf;

  -- -----------------------------------------------------------------
  function slc_common_2af (d: SLC_COMMON_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLC_COMMON_LEN-1 downto 0);
  begin
    v := d.slcid
         & d.tcsent
         & d.poseta
         & d.posphi
         & d.ptthresh
         & d.charge;
    return v;
  end function slc_common_2af;

  function slc_common_2rf (v: slc_common_at)
  return SLC_COMMON_rt is
    variable b : SLC_COMMON_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLC_COMMON_LEN - 1; -- 32
    lsb := msb - SLC_COMMON_SLCID_LEN + 1; -- 2
    b.slcid := v(msb downto lsb); -- 31 30
    msb := lsb - 1;
    lsb := msb - SLC_COMMON_TCSENT_LEN + 1; -- 1
    b.tcsent := v(msb); -- 29
    msb := lsb - 1;
    lsb := msb - SLC_COMMON_POSETA_LEN + 1; -- 15
    b.poseta := v(msb downto lsb); -- 28 14
    msb := lsb - 1;
    lsb := msb - SLC_COMMON_POSPHI_LEN + 1; -- 9
    b.posphi := v(msb downto lsb); -- 13 5
    msb := lsb - 1;
    lsb := msb - SLC_COMMON_PTTHRESH_LEN + 1; -- 4
    b.ptthresh := v(msb downto lsb); -- 4 1
    msb := lsb - 1;
    lsb := msb - SLC_COMMON_CHARGE_LEN + 1; -- 1
    b.charge := v(msb); -- 0
    return b;
  end function slc_common_2rf;

  -- -----------------------------------------------------------------
  function slc_endcap_2af (d: SLC_ENDCAP_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLC_ENDCAP_LEN-1 downto 0);
  begin
    v := slc_common_2af(d.slc_common_r)
         & d.seg_angdtheta
         & d.seg_angdphi
         & d.nswseg_poseta
         & d.nswseg_posphi
         & d.nswseg_angdtheta;
    return v;
  end function slc_endcap_2af;

  function slc_endcap_2rf (v: slc_endcap_at)
  return SLC_ENDCAP_rt is
    variable b : SLC_ENDCAP_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLC_ENDCAP_LEN - 1; -- 70
    lsb := msb - SLC_ENDCAP_SLC_COMMON_LEN + 1; -- 32
    b.slc_common_r := slc_common_2rf(v(msb downto lsb)); -- 69 38
    msb := lsb - 1;
    lsb := msb - SLC_ENDCAP_SEG_ANGDTHETA_LEN + 1; -- 7
    b.seg_angdtheta := v(msb downto lsb); -- 37 31
    msb := lsb - 1;
    lsb := msb - SLC_ENDCAP_SEG_ANGDPHI_LEN + 1; -- 4
    b.seg_angdphi := v(msb downto lsb); -- 30 27
    msb := lsb - 1;
    lsb := msb - SLC_ENDCAP_NSWSEG_POSETA_LEN + 1; -- 14
    b.nswseg_poseta := v(msb downto lsb); -- 26 13
    msb := lsb - 1;
    lsb := msb - SLC_ENDCAP_NSWSEG_POSPHI_LEN + 1; -- 8
    b.nswseg_posphi := v(msb downto lsb); -- 12 5
    msb := lsb - 1;
    lsb := msb - SLC_ENDCAP_NSWSEG_ANGDTHETA_LEN + 1; -- 5
    b.nswseg_angdtheta := v(msb downto lsb); -- 4 0
    return b;
  end function slc_endcap_2rf;

  -- -----------------------------------------------------------------
  function slc_barrel_2af (d: SLC_BARREL_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLC_BARREL_LEN-1 downto 0);
  begin
    v := slc_common_2af(d.slc_common_r)
         & d.rpc0_posz
         & d.rpc1_posz
         & d.rpc2_posz
         & d.rpc3_posz
         & d.cointype;
    return v;
  end function slc_barrel_2af;

  function slc_barrel_2rf (v: slc_barrel_at)
  return SLC_BARREL_rt is
    variable b : SLC_BARREL_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLC_BARREL_LEN - 1; -- 75
    lsb := msb - SLC_BARREL_SLC_COMMON_LEN + 1; -- 32
    b.slc_common_r := slc_common_2rf(v(msb downto lsb)); -- 74 43
    msb := lsb - 1;
    lsb := msb - SLC_BARREL_RPC0_POSZ_LEN + 1; -- 10
    b.rpc0_posz := v(msb downto lsb); -- 42 33
    msb := lsb - 1;
    lsb := msb - SLC_BARREL_RPC1_POSZ_LEN + 1; -- 10
    b.rpc1_posz := v(msb downto lsb); -- 32 23
    msb := lsb - 1;
    lsb := msb - SLC_BARREL_RPC2_POSZ_LEN + 1; -- 10
    b.rpc2_posz := v(msb downto lsb); -- 22 13
    msb := lsb - 1;
    lsb := msb - SLC_BARREL_RPC3_POSZ_LEN + 1; -- 10
    b.rpc3_posz := v(msb downto lsb); -- 12 3
    msb := lsb - 1;
    lsb := msb - SLC_BARREL_COINTYPE_LEN + 1; -- 3
    b.cointype := v(msb downto lsb); -- 2 0
    return b;
  end function slc_barrel_2rf;

  -- -----------------------------------------------------------------
  function slcproc_pipe_common_2af (d: SLCPROC_PIPE_COMMON_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPROC_PIPE_COMMON_LEN-1 downto 0);
  begin
    v := d.busy
         & d.destsl
         & d.phimod
         & d.inn_vec_mdtid
         & d.mid_vec_mdtid
         & d.out_vec_mdtid
         & d.ext_vec_mdtid;
    return v;
  end function slcproc_pipe_common_2af;

  function slcproc_pipe_common_2rf (v: slcproc_pipe_common_at)
  return SLCPROC_PIPE_COMMON_rt is
    variable b : SLCPROC_PIPE_COMMON_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPROC_PIPE_COMMON_LEN - 1; -- 35
    lsb := msb - SLCPROC_PIPE_COMMON_BUSY_LEN + 1; -- 1
    b.busy := v(msb); -- 34
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_DESTSL_LEN + 1; -- 2
    b.destsl := v(msb downto lsb); -- 33 32
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_PHIMOD_LEN + 1; -- 8
    b.phimod := v(msb downto lsb); -- 31 24
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_INN_VEC_MDTID_LEN + 1; -- 6
    b.inn_vec_mdtid := v(msb downto lsb); -- 23 18
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_MID_VEC_MDTID_LEN + 1; -- 6
    b.mid_vec_mdtid := v(msb downto lsb); -- 17 12
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_OUT_VEC_MDTID_LEN + 1; -- 6
    b.out_vec_mdtid := v(msb downto lsb); -- 11 6
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_COMMON_EXT_VEC_MDTID_LEN + 1; -- 6
    b.ext_vec_mdtid := v(msb downto lsb); -- 5 0
    return b;
  end function slcproc_pipe_common_2rf;

  -- -----------------------------------------------------------------
  function slcproc_pipe_endcap_2af (d: SLCPROC_PIPE_ENDCAP_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPROC_PIPE_ENDCAP_LEN-1 downto 0);
  begin
    v := slcproc_pipe_common_2af(d.slcproc_pipe_common_r)
         & slc_endcap_2af(d.slc_endcap_r)
         & slc_muid_2af(d.slc_muid_r);
    return v;
  end function slcproc_pipe_endcap_2af;

  function slcproc_pipe_endcap_2rf (v: slcproc_pipe_endcap_at)
  return SLCPROC_PIPE_ENDCAP_rt is
    variable b : SLCPROC_PIPE_ENDCAP_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPROC_PIPE_ENDCAP_LEN - 1; -- 125
    lsb := msb - SLCPROC_PIPE_ENDCAP_SLCPROC_PIPE_COMMON_LEN + 1; -- 35
    b.slcproc_pipe_common_r := slcproc_pipe_common_2rf(v(msb downto lsb)); -- 124 90
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_ENDCAP_SLC_ENDCAP_LEN + 1; -- 70
    b.slc_endcap_r := slc_endcap_2rf(v(msb downto lsb)); -- 89 20
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_ENDCAP_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 19 0
    return b;
  end function slcproc_pipe_endcap_2rf;

  -- -----------------------------------------------------------------
  function slcproc_pipe_barrel_2af (d: SLCPROC_PIPE_BARREL_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPROC_PIPE_BARREL_LEN-1 downto 0);
  begin
    v := slcproc_pipe_common_2af(d.slcproc_pipe_common_r)
         & slc_barrel_2af(d.slc_barrel_r)
         & slc_muid_2af(d.slc_muid_r);
    return v;
  end function slcproc_pipe_barrel_2af;

  function slcproc_pipe_barrel_2rf (v: slcproc_pipe_barrel_at)
  return SLCPROC_PIPE_BARREL_rt is
    variable b : SLCPROC_PIPE_BARREL_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPROC_PIPE_BARREL_LEN - 1; -- 130
    lsb := msb - SLCPROC_PIPE_BARREL_SLCPROC_PIPE_COMMON_LEN + 1; -- 35
    b.slcproc_pipe_common_r := slcproc_pipe_common_2rf(v(msb downto lsb)); -- 129 95
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_BARREL_SLC_BARREL_LEN + 1; -- 75
    b.slc_barrel_r := slc_barrel_2rf(v(msb downto lsb)); -- 94 20
    msb := lsb - 1;
    lsb := msb - SLCPROC_PIPE_BARREL_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 19 0
    return b;
  end function slcproc_pipe_barrel_2rf;

  -- -----------------------------------------------------------------
  function tdc_2af (d: TDC_rt)
  return std_logic_vector is
    variable v : std_logic_vector(TDC_LEN-1 downto 0);
  begin
    v := d.chanid
         & d.edgemode
         & d.coarsetime
         & d.finetime
         & d.pulsewidth;
    return v;
  end function tdc_2af;

  function tdc_2rf (v: tdc_at)
  return TDC_rt is
    variable b : TDC_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := TDC_LEN - 1; -- 32
    lsb := msb - TDC_CHANID_LEN + 1; -- 5
    b.chanid := v(msb downto lsb); -- 31 27
    msb := lsb - 1;
    lsb := msb - TDC_EDGEMODE_LEN + 1; -- 2
    b.edgemode := v(msb downto lsb); -- 26 25
    msb := lsb - 1;
    lsb := msb - TDC_COARSETIME_LEN + 1; -- 12
    b.coarsetime := v(msb downto lsb); -- 24 13
    msb := lsb - 1;
    lsb := msb - TDC_FINETIME_LEN + 1; -- 5
    b.finetime := v(msb downto lsb); -- 12 8
    msb := lsb - 1;
    lsb := msb - TDC_PULSEWIDTH_LEN + 1; -- 8
    b.pulsewidth := v(msb downto lsb); -- 7 0
    return b;
  end function tdc_2rf;

  -- -----------------------------------------------------------------
  function tdcpolmux_2af (d: TDCPOLMUX_rt)
  return std_logic_vector is
    variable v : std_logic_vector(TDCPOLMUX_LEN-1 downto 0);
  begin
    v := tdc_2af(d.tdc_r)
         & d.fiberid
         & d.elinkid
         & d.datavalid;
    return v;
  end function tdcpolmux_2af;

  function tdcpolmux_2rf (v: tdcpolmux_at)
  return TDCPOLMUX_rt is
    variable b : TDCPOLMUX_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := TDCPOLMUX_LEN - 1; -- 42
    lsb := msb - TDCPOLMUX_TDC_LEN + 1; -- 32
    b.tdc_r := tdc_2rf(v(msb downto lsb)); -- 41 10
    msb := lsb - 1;
    lsb := msb - TDCPOLMUX_FIBERID_LEN + 1; -- 5
    b.fiberid := v(msb downto lsb); -- 9 5
    msb := lsb - 1;
    lsb := msb - TDCPOLMUX_ELINKID_LEN + 1; -- 4
    b.elinkid := v(msb downto lsb); -- 4 1
    msb := lsb - 1;
    lsb := msb - TDCPOLMUX_DATAVALID_LEN + 1; -- 1
    b.datavalid := v(msb); -- 0
    return b;
  end function tdcpolmux_2rf;

  -- -----------------------------------------------------------------
  function slcproc_hps_sf_2af (d: SLCPROC_HPS_SF_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPROC_HPS_SF_LEN-1 downto 0);
  begin
    v := d.slc_valid
         & slc_muid_2af(d.slc_muid_r)
         & d.mdtseg_dest
         & d.vec_mdtid
         & d.vec_pos
         & d.vec_ang;
    return v;
  end function slcproc_hps_sf_2af;

  function slcproc_hps_sf_2rf (v: slcproc_hps_sf_at)
  return SLCPROC_HPS_SF_rt is
    variable b : SLCPROC_HPS_SF_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPROC_HPS_SF_LEN - 1; -- 49
    lsb := msb - SLCPROC_HPS_SF_SLC_VALID_LEN + 1; -- 1
    b.slc_valid := v(msb); -- 48
    msb := lsb - 1;
    lsb := msb - SLCPROC_HPS_SF_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 47 28
    msb := lsb - 1;
    lsb := msb - SLCPROC_HPS_SF_MDTSEG_DEST_LEN + 1; -- 2
    b.mdtseg_dest := v(msb downto lsb); -- 27 26
    msb := lsb - 1;
    lsb := msb - SLCPROC_HPS_SF_VEC_MDTID_LEN + 1; -- 6
    b.vec_mdtid := v(msb downto lsb); -- 25 20
    msb := lsb - 1;
    lsb := msb - SLCPROC_HPS_SF_VEC_POS_LEN + 1; -- 10
    b.vec_pos := v(msb downto lsb); -- 19 10
    msb := lsb - 1;
    lsb := msb - SLCPROC_HPS_SF_VEC_ANG_LEN + 1; -- 10
    b.vec_ang := v(msb downto lsb); -- 9 0
    return b;
  end function slcproc_hps_sf_2rf;

  -- -----------------------------------------------------------------
  function tar_2af (d: TAR_rt)
  return std_logic_vector is
    variable v : std_logic_vector(TAR_LEN-1 downto 0);
  begin
    v := d.mdt_tube_layer
         & d.mdt_tube_num
         & d.mdt_tube_rho
         & d.mdt_tube_z
         & d.mdt_tube_time;
    return v;
  end function tar_2af;

  function tar_2rf (v: tar_at)
  return TAR_rt is
    variable b : TAR_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := TAR_LEN - 1; -- 71
    lsb := msb - TAR_MDT_TUBE_LAYER_LEN + 1; -- 5
    b.mdt_tube_layer := v(msb downto lsb); -- 70 66
    msb := lsb - 1;
    lsb := msb - TAR_MDT_TUBE_NUM_LEN + 1; -- 9
    b.mdt_tube_num := v(msb downto lsb); -- 65 57
    msb := lsb - 1;
    lsb := msb - TAR_MDT_TUBE_RHO_LEN + 1; -- 19
    b.mdt_tube_rho := v(msb downto lsb); -- 56 38
    msb := lsb - 1;
    lsb := msb - TAR_MDT_TUBE_Z_LEN + 1; -- 20
    b.mdt_tube_z := v(msb downto lsb); -- 37 18
    msb := lsb - 1;
    lsb := msb - TAR_MDT_TUBE_TIME_LEN + 1; -- 18
    b.mdt_tube_time := v(msb downto lsb); -- 17 0
    return b;
  end function tar_2rf;

  -- -----------------------------------------------------------------
  function hps_lsf_2af (d: HPS_LSF_rt)
  return std_logic_vector is
    variable v : std_logic_vector(HPS_LSF_LEN-1 downto 0);
  begin
    v := d.data_valid
         & d.mdt_localx
         & d.mdt_localy
         & d.mdt_radius;
    return v;
  end function hps_lsf_2af;

  function hps_lsf_2rf (v: hps_lsf_at)
  return HPS_LSF_rt is
    variable b : HPS_LSF_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := HPS_LSF_LEN - 1; -- 40
    lsb := msb - HPS_LSF_DATA_VALID_LEN + 1; -- 1
    b.data_valid := v(msb); -- 39
    msb := lsb - 1;
    lsb := msb - HPS_LSF_MDT_LOCALX_LEN + 1; -- 15
    b.mdt_localx := v(msb downto lsb); -- 38 24
    msb := lsb - 1;
    lsb := msb - HPS_LSF_MDT_LOCALY_LEN + 1; -- 15
    b.mdt_localy := v(msb downto lsb); -- 23 9
    msb := lsb - 1;
    lsb := msb - HPS_LSF_MDT_RADIUS_LEN + 1; -- 9
    b.mdt_radius := v(msb downto lsb); -- 8 0
    return b;
  end function hps_lsf_2rf;

  -- -----------------------------------------------------------------
  function hps_csf_2af (d: HPS_CSF_rt)
  return std_logic_vector is
    variable v : std_logic_vector(HPS_CSF_LEN-1 downto 0);
  begin
    v := d.data_valid
         & d.mdt_localx
         & d.mdt_localy
         & d.mdt_radius;
    return v;
  end function hps_csf_2af;

  function hps_csf_2rf (v: hps_csf_at)
  return HPS_CSF_rt is
    variable b : HPS_CSF_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := HPS_CSF_LEN - 1; -- 40
    lsb := msb - HPS_CSF_DATA_VALID_LEN + 1; -- 1
    b.data_valid := v(msb); -- 39
    msb := lsb - 1;
    lsb := msb - HPS_CSF_MDT_LOCALX_LEN + 1; -- 15
    b.mdt_localx := v(msb downto lsb); -- 38 24
    msb := lsb - 1;
    lsb := msb - HPS_CSF_MDT_LOCALY_LEN + 1; -- 15
    b.mdt_localy := v(msb downto lsb); -- 23 9
    msb := lsb - 1;
    lsb := msb - HPS_CSF_MDT_RADIUS_LEN + 1; -- 9
    b.mdt_radius := v(msb downto lsb); -- 8 0
    return b;
  end function hps_csf_2rf;

  -- -----------------------------------------------------------------
  function slcpipe_ptcalc_2af (d: SLCPIPE_PTCALC_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPIPE_PTCALC_LEN-1 downto 0);
  begin
    v := slc_muid_2af(d.slc_muid_r)
         & d.phimod
         & d.charge;
    return v;
  end function slcpipe_ptcalc_2af;

  function slcpipe_ptcalc_2rf (v: slcpipe_ptcalc_at)
  return SLCPIPE_PTCALC_rt is
    variable b : SLCPIPE_PTCALC_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPIPE_PTCALC_LEN - 1; -- 29
    lsb := msb - SLCPIPE_PTCALC_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 28 9
    msb := lsb - 1;
    lsb := msb - SLCPIPE_PTCALC_PHIMOD_LEN + 1; -- 8
    b.phimod := v(msb downto lsb); -- 8 1
    msb := lsb - 1;
    lsb := msb - SLCPIPE_PTCALC_CHARGE_LEN + 1; -- 1
    b.charge := v(msb); -- 0
    return b;
  end function slcpipe_ptcalc_2rf;

  -- -----------------------------------------------------------------
  function sf_2af (d: SF_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SF_LEN-1 downto 0);
  begin
    v := slc_muid_2af(d.slc_muid_r)
         & d.vec_mdtid
         & d.segvalid
         & d.segpos
         & d.segangle
         & d.segquality;
    return v;
  end function sf_2af;

  function sf_2rf (v: sf_at)
  return SF_rt is
    variable b : SF_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SF_LEN - 1; -- 56
    lsb := msb - SF_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 55 36
    msb := lsb - 1;
    lsb := msb - SF_VEC_MDTID_LEN + 1; -- 6
    b.vec_mdtid := v(msb downto lsb); -- 35 30
    msb := lsb - 1;
    lsb := msb - SF_SEGVALID_LEN + 1; -- 1
    b.segvalid := v(msb); -- 29
    msb := lsb - 1;
    lsb := msb - SF_SEGPOS_LEN + 1; -- 17
    b.segpos := v(msb downto lsb); -- 28 12
    msb := lsb - 1;
    lsb := msb - SF_SEGANGLE_LEN + 1; -- 11
    b.segangle := v(msb downto lsb); -- 11 1
    msb := lsb - 1;
    lsb := msb - SF_SEGQUALITY_LEN + 1; -- 1
    b.segquality := v(msb); -- 0
    return b;
  end function sf_2rf;

  -- -----------------------------------------------------------------
  function ptcalc_2af (d: PTCALC_rt)
  return std_logic_vector is
    variable v : std_logic_vector(PTCALC_LEN-1 downto 0);
  begin
    v := slc_muid_2af(d.slc_muid_r)
         & d.eta
         & d.pt
         & d.ptthresh
         & d.charge
         & d.nsegments
         & d.quality;
    return v;
  end function ptcalc_2af;

  function ptcalc_2rf (v: ptcalc_at)
  return PTCALC_rt is
    variable b : PTCALC_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := PTCALC_LEN - 1; -- 54
    lsb := msb - PTCALC_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 53 34
    msb := lsb - 1;
    lsb := msb - PTCALC_ETA_LEN + 1; -- 15
    b.eta := v(msb downto lsb); -- 33 19
    msb := lsb - 1;
    lsb := msb - PTCALC_PT_LEN + 1; -- 9
    b.pt := v(msb downto lsb); -- 18 10
    msb := lsb - 1;
    lsb := msb - PTCALC_PTTHRESH_LEN + 1; -- 4
    b.ptthresh := v(msb downto lsb); -- 9 6
    msb := lsb - 1;
    lsb := msb - PTCALC_CHARGE_LEN + 1; -- 1
    b.charge := v(msb); -- 5
    msb := lsb - 1;
    lsb := msb - PTCALC_NSEGMENTS_LEN + 1; -- 2
    b.nsegments := v(msb downto lsb); -- 4 3
    msb := lsb - 1;
    lsb := msb - PTCALC_QUALITY_LEN + 1; -- 3
    b.quality := v(msb downto lsb); -- 2 0
    return b;
  end function ptcalc_2rf;

  -- -----------------------------------------------------------------
  function slcpipe_mtc_endcap_2af (d: SLCPIPE_MTC_ENDCAP_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPIPE_MTC_ENDCAP_LEN-1 downto 0);
  begin
    v := slc_muid_2af(d.slc_muid_r)
         & slc_common_2af(d.slc_common_r)
         & d.busy
         & d.destsl;
    return v;
  end function slcpipe_mtc_endcap_2af;

  function slcpipe_mtc_endcap_2rf (v: slcpipe_mtc_endcap_at)
  return SLCPIPE_MTC_ENDCAP_rt is
    variable b : SLCPIPE_MTC_ENDCAP_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPIPE_MTC_ENDCAP_LEN - 1; -- 55
    lsb := msb - SLCPIPE_MTC_ENDCAP_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 54 35
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_ENDCAP_SLC_COMMON_LEN + 1; -- 32
    b.slc_common_r := slc_common_2rf(v(msb downto lsb)); -- 34 3
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_ENDCAP_BUSY_LEN + 1; -- 1
    b.busy := v(msb); -- 2
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_ENDCAP_DESTSL_LEN + 1; -- 2
    b.destsl := v(msb downto lsb); -- 1 0
    return b;
  end function slcpipe_mtc_endcap_2rf;

  -- -----------------------------------------------------------------
  function slcpipe_mtc_barrel_2af (d: SLCPIPE_MTC_BARREL_rt)
  return std_logic_vector is
    variable v : std_logic_vector(SLCPIPE_MTC_BARREL_LEN-1 downto 0);
  begin
    v := d.cointype
         & slc_muid_2af(d.slc_muid_r)
         & slc_common_2af(d.slc_common_r)
         & d.busy
         & d.destsl;
    return v;
  end function slcpipe_mtc_barrel_2af;

  function slcpipe_mtc_barrel_2rf (v: slcpipe_mtc_barrel_at)
  return SLCPIPE_MTC_BARREL_rt is
    variable b : SLCPIPE_MTC_BARREL_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := SLCPIPE_MTC_BARREL_LEN - 1; -- 58
    lsb := msb - SLCPIPE_MTC_BARREL_COINTYPE_LEN + 1; -- 3
    b.cointype := v(msb downto lsb); -- 57 55
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_BARREL_SLC_MUID_LEN + 1; -- 20
    b.slc_muid_r := slc_muid_2rf(v(msb downto lsb)); -- 54 35
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_BARREL_SLC_COMMON_LEN + 1; -- 32
    b.slc_common_r := slc_common_2rf(v(msb downto lsb)); -- 34 3
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_BARREL_BUSY_LEN + 1; -- 1
    b.busy := v(msb); -- 2
    msb := lsb - 1;
    lsb := msb - SLCPIPE_MTC_BARREL_DESTSL_LEN + 1; -- 2
    b.destsl := v(msb downto lsb); -- 1 0
    return b;
  end function slcpipe_mtc_barrel_2rf;

  -- -----------------------------------------------------------------
  function mtc_2af (d: MTC_rt)
  return std_logic_vector is
    variable v : std_logic_vector(MTC_LEN-1 downto 0);
  begin
    v := slc_common_2af(d.slc_common_r)
         & d.eta
         & d.pt
         & d.ptthresh
         & d.charge
         & d.procflags
         & d.nsegments
         & d.quality;
    return v;
  end function mtc_2af;

  function mtc_2rf (v: mtc_at)
  return MTC_rt is
    variable b : MTC_rt;
    variable msb : integer;
    variable lsb : integer;
  begin
    msb := MTC_LEN - 1; -- 70
    lsb := msb - MTC_SLC_COMMON_LEN + 1; -- 32
    b.slc_common_r := slc_common_2rf(v(msb downto lsb)); -- 69 38
    msb := lsb - 1;
    lsb := msb - MTC_ETA_LEN + 1; -- 15
    b.eta := v(msb downto lsb); -- 37 23
    msb := lsb - 1;
    lsb := msb - MTC_PT_LEN + 1; -- 9
    b.pt := v(msb downto lsb); -- 22 14
    msb := lsb - 1;
    lsb := msb - MTC_PTTHRESH_LEN + 1; -- 4
    b.ptthresh := v(msb downto lsb); -- 13 10
    msb := lsb - 1;
    lsb := msb - MTC_CHARGE_LEN + 1; -- 1
    b.charge := v(msb); -- 9
    msb := lsb - 1;
    lsb := msb - MTC_PROCFLAGS_LEN + 1; -- 4
    b.procflags := v(msb downto lsb); -- 8 5
    msb := lsb - 1;
    lsb := msb - MTC_NSEGMENTS_LEN + 1; -- 2
    b.nsegments := v(msb downto lsb); -- 4 3
    msb := lsb - 1;
    lsb := msb - MTC_QUALITY_LEN + 1; -- 3
    b.quality := v(msb downto lsb); -- 2 0
    return b;
  end function mtc_2rf;

  -- -------------------------------------------------------------------

end package body mdttp_functions_pkg;
