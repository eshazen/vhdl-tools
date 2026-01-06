-- -------------------------------------------------------------------------------------------------
-- Auto-generated from:
-- https://docs.google.com/spreadsheets/d/1oJh-NPv990n6AzXXZ7cBaySrltqBO-eGucrsnOx_r4s
-- -------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library l0mdt_lib;
use l0mdt_lib.mdttp_constants_pkg.all;

package mdttp_types_pkg is

  constant DF_HASH : std_logic_vector(31 downto 0) := x"b70475b5";

  -- -----------------------------------------------------------------
  -- Added temporary FELIX type for experimenting
  -- -----------------------------------------------------------------

  type felix_out_rt is record
    data    : std_logic_vector(FELIX_OUT_DATA_LEN-1 downto 0);
    dv      : std_logic;                -- data valid
    header  : std_logic;                -- ='1' sending header
    trailer : std_logic;                -- ='1' sending trailer
  end record felix_out_rt;

  -- -----------------------------------------------------------------
  subtype SLC_MUID_at is std_logic_vector(19 downto 0);

  type slc_muid_rt is record
    -- SLc Identification (up to 3)
    slcid : std_logic_vector(SLC_MUID_SLCID_LEN-1 downto 0);  -- 1
    -- SL board ID (based on the fiber ID)
    slid  : std_logic_vector(SLC_MUID_SLID_LEN-1 downto 0);   -- 5
    -- BCID from SLC
    bcid  : std_logic_vector(SLC_MUID_BCID_LEN-1 downto 0);   -- 11
  end record slc_muid_rt;

  -- -----------------------------------------------------------------
  subtype SLC_COMMON_at is std_logic_vector(31 downto 0);

  type slc_common_rt is record
    -- SLc Identification (up to 3)
    slcid    : std_logic_vector(SLC_COMMON_SLCID_LEN-1 downto 0);     -- 1
    -- TC sent to MDT TP
    tcsent   : std_logic;
    -- SLc Eta Position
    poseta   : std_logic_vector(SLC_COMMON_POSETA_LEN-1 downto 0);    -- 14
    -- SLc Phi Position
    posphi   : std_logic_vector(SLC_COMMON_POSPHI_LEN-1 downto 0);    -- 8
    -- SLc highest pT threshold passed
    ptthresh : std_logic_vector(SLC_COMMON_PTTHRESH_LEN-1 downto 0);  -- 3
    -- SLc charge
    charge   : std_logic;
  end record slc_common_rt;

  -- -----------------------------------------------------------------
  subtype SLC_ENDCAP_at is std_logic_vector(69 downto 0);

  type slc_endcap_rt is record
    -- struct SLC_COMMON
    slc_common_r     : SLC_COMMON_rt;
    -- SLc Segment Angle wrt Eta position
    seg_angdtheta    : std_logic_vector(SLC_ENDCAP_SEG_ANGDTHETA_LEN-1 downto 0);  -- 6
    -- SLc Segment Angle wrt Phi position
    seg_angdphi      : std_logic_vector(SLC_ENDCAP_SEG_ANGDPHI_LEN-1 downto 0);  -- 3
    -- NSW segment eta position
    nswseg_poseta    : std_logic_vector(SLC_ENDCAP_NSWSEG_POSETA_LEN-1 downto 0);  -- 13
    -- NSW segment phi position
    nswseg_posphi    : std_logic_vector(SLC_ENDCAP_NSWSEG_POSPHI_LEN-1 downto 0);  -- 7
    -- NSW segment angle wrt Eta position
    nswseg_angdtheta : std_logic_vector(SLC_ENDCAP_NSWSEG_ANGDTHETA_LEN-1 downto 0);  -- 4
  end record slc_endcap_rt;

  -- -----------------------------------------------------------------
  subtype SLC_BARREL_at is std_logic_vector(74 downto 0);

  type slc_barrel_rt is record
    -- struct SLC_COMMON
    slc_common_r : SLC_COMMON_rt;
    -- SLc Hit Z Position in RPC0
    rpc0_posz    : std_logic_vector(SLC_BARREL_RPC0_POSZ_LEN-1 downto 0);  -- 9
    -- SLc Hit Z Position in RPC1
    rpc1_posz    : std_logic_vector(SLC_BARREL_RPC1_POSZ_LEN-1 downto 0);  -- 9
    -- SLc Hit Z Position in RPC2
    rpc2_posz    : std_logic_vector(SLC_BARREL_RPC2_POSZ_LEN-1 downto 0);  -- 9
    -- SLc Hit Z Position in RPC3
    rpc3_posz    : std_logic_vector(SLC_BARREL_RPC3_POSZ_LEN-1 downto 0);  -- 9
    -- SLc coincidence type
    cointype     : std_logic_vector(SLC_BARREL_COINTYPE_LEN-1 downto 0);   -- 2
  end record slc_barrel_rt;

  -- -----------------------------------------------------------------
  subtype SLCPROC_PIPE_COMMON_at is std_logic_vector(34 downto 0);

  type slcproc_pipe_common_rt is record
    -- SLc busy flag
    busy          : std_logic;
    -- SLc board destination
    destsl        : std_logic_vector(SLCPROC_PIPE_COMMON_DESTSL_LEN-1 downto 0);  -- 1
    -- SLc phimod
    phimod        : std_logic_vector(SLCPROC_PIPE_COMMON_PHIMOD_LEN-1 downto 0);  -- 7
    -- SLc Inner Vector MDT chamber ID
    inn_vec_mdtid : std_logic_vector(SLCPROC_PIPE_COMMON_INN_VEC_MDTID_LEN-1 downto 0);  -- 5
    -- SLc Middle Vector MDT chamber ID
    mid_vec_mdtid : std_logic_vector(SLCPROC_PIPE_COMMON_MID_VEC_MDTID_LEN-1 downto 0);  -- 5
    -- SLc Outer Vector MDT chamber ID
    out_vec_mdtid : std_logic_vector(SLCPROC_PIPE_COMMON_OUT_VEC_MDTID_LEN-1 downto 0);  -- 5
    -- SLc Extra Vector MDT chamber ID
    ext_vec_mdtid : std_logic_vector(SLCPROC_PIPE_COMMON_EXT_VEC_MDTID_LEN-1 downto 0);  -- 5
  end record slcproc_pipe_common_rt;

  -- -----------------------------------------------------------------
  subtype SLCPROC_PIPE_ENDCAP_at is std_logic_vector(124 downto 0);

  type slcproc_pipe_endcap_rt is record
    -- struct SLCPROC_PIPE_COMMON
    slcproc_pipe_common_r : SLCPROC_PIPE_COMMON_rt;
    -- struct SLC_ENDCAP
    slc_endcap_r          : SLC_ENDCAP_rt;
    -- struct SLC_MUID
    slc_muid_r            : SLC_MUID_rt;
  end record slcproc_pipe_endcap_rt;

  -- -----------------------------------------------------------------
  subtype SLCPROC_PIPE_BARREL_at is std_logic_vector(129 downto 0);

  type slcproc_pipe_barrel_rt is record
    -- struct SLCPROC_PIPE_COMMON
    slcproc_pipe_common_r : SLCPROC_PIPE_COMMON_rt;
    -- struct SLC_BARREL
    slc_barrel_r          : SLC_BARREL_rt;
    -- struct SLC_MUID
    slc_muid_r            : SLC_MUID_rt;
  end record slcproc_pipe_barrel_rt;

  -- -----------------------------------------------------------------
  subtype TDC_at is std_logic_vector(31 downto 0);

  type tdc_rt is record
    -- Channel number within TDC
    chanid     : std_logic_vector(TDC_CHANID_LEN-1 downto 0);      -- 4
    -- Edge or pair mode
    edgemode   : std_logic_vector(TDC_EDGEMODE_LEN-1 downto 0);    -- 1
    -- TDC BCID
    coarsetime : std_logic_vector(TDC_COARSETIME_LEN-1 downto 0);  -- 11
    -- TDC fine time with BCID
    finetime   : std_logic_vector(TDC_FINETIME_LEN-1 downto 0);    -- 4
    -- Pulse width
    pulsewidth : std_logic_vector(TDC_PULSEWIDTH_LEN-1 downto 0);  -- 7
  end record tdc_rt;

  -- -----------------------------------------------------------------
  subtype TDCPOLMUX_at is std_logic_vector(41 downto 0);

  type tdcpolmux_rt is record
    -- struct TDC
    tdc_r     : TDC_rt;
    -- Fiber ID within board
    fiberid   : std_logic_vector(TDCPOLMUX_FIBERID_LEN-1 downto 0);  -- 4
    -- Elink ID within fiber
    elinkid   : std_logic_vector(TDCPOLMUX_ELINKID_LEN-1 downto 0);  -- 3
    -- Valid bit
    datavalid : std_logic;
  end record tdcpolmux_rt;

  -- -----------------------------------------------------------------
  subtype SLCPROC_HPS_SF_at is std_logic_vector(48 downto 0);

  type slcproc_hps_sf_rt is record
    -- SLC Valid bit
    slc_valid   : std_logic;
    -- struct SLC_MUID
    slc_muid_r  : SLC_MUID_rt;
    -- inner MDT segment chip destination
    mdtseg_dest : std_logic_vector(SLCPROC_HPS_SF_MDTSEG_DEST_LEN-1 downto 0);  -- 1
    -- SLc Inner Vector MDT chamber ID
    vec_mdtid   : std_logic_vector(SLCPROC_HPS_SF_VEC_MDTID_LEN-1 downto 0);  -- 5
    -- SLc inner vector rho position
    vec_pos     : std_logic_vector(SLCPROC_HPS_SF_VEC_POS_LEN-1 downto 0);  -- 9
    -- SLc inner vector theta angle
    vec_ang     : std_logic_vector(SLCPROC_HPS_SF_VEC_ANG_LEN-1 downto 0);  -- 9
  end record slcproc_hps_sf_rt;

  -- -----------------------------------------------------------------
  subtype TAR_at is std_logic_vector(70 downto 0);

  type tar_rt is record
    -- Tube layer within one station
    mdt_tube_layer : std_logic_vector(TAR_MDT_TUBE_LAYER_LEN-1 downto 0);  -- 4
    -- Tube number within one station
    mdt_tube_num   : std_logic_vector(TAR_MDT_TUBE_NUM_LEN-1 downto 0);   -- 8
    -- Tube radial position
    mdt_tube_rho   : std_logic_vector(TAR_MDT_TUBE_RHO_LEN-1 downto 0);   -- 18
    -- Tube position along z
    mdt_tube_z     : std_logic_vector(TAR_MDT_TUBE_Z_LEN-1 downto 0);     -- 19
    -- Tube (uncalibrated) time
    mdt_tube_time  : std_logic_vector(TAR_MDT_TUBE_TIME_LEN-1 downto 0);  -- 17
  end record tar_rt;

  -- -----------------------------------------------------------------
  subtype HPS_LSF_at is std_logic_vector(39 downto 0);

  type hps_lsf_rt is record
    -- Data Valid bit
    data_valid : std_logic;
    -- Tube local position along precision coord
    mdt_localx : std_logic_vector(HPS_LSF_MDT_LOCALX_LEN-1 downto 0);  -- 14
    -- Tube local position along second coord
    mdt_localy : std_logic_vector(HPS_LSF_MDT_LOCALY_LEN-1 downto 0);  -- 14
    -- Tube drift radius
    mdt_radius : std_logic_vector(HPS_LSF_MDT_RADIUS_LEN-1 downto 0);  -- 8
  end record hps_lsf_rt;

  -- -----------------------------------------------------------------
  subtype HPS_CSF_at is std_logic_vector(39 downto 0);

  type hps_csf_rt is record
    -- Data Valid bit
    data_valid : std_logic;
    -- Tube local position along precision coord
    mdt_localx : std_logic_vector(HPS_CSF_MDT_LOCALX_LEN-1 downto 0);  -- 14
    -- Tube local position along second coord
    mdt_localy : std_logic_vector(HPS_CSF_MDT_LOCALY_LEN-1 downto 0);  -- 14
    -- Tube drift radius
    mdt_radius : std_logic_vector(HPS_CSF_MDT_RADIUS_LEN-1 downto 0);  -- 8
  end record hps_csf_rt;

  -- -----------------------------------------------------------------
  subtype SLCPIPE_PTCALC_at is std_logic_vector(28 downto 0);

  type slcpipe_ptcalc_rt is record
    -- struct SLC_MUID
    slc_muid_r : SLC_MUID_rt;
    -- (COPY)
    phimod     : std_logic_vector(SLCPIPE_PTCALC_PHIMOD_LEN-1 downto 0);  -- 7
    -- (COPY)
    charge     : std_logic;
  end record slcpipe_ptcalc_rt;

  -- -----------------------------------------------------------------
  subtype SF_at is std_logic_vector(55 downto 0);

  type sf_rt is record
    -- struct SLC_MUID
    slc_muid_r : SLC_MUID_rt;
    -- (COPY)
    vec_mdtid  : std_logic_vector(SF_VEC_MDTID_LEN-1 downto 0);  -- 5
    -- SF MDT segment valid bit
    segvalid   : std_logic;
    -- SF MDT segment position along the precision coord
    segpos     : std_logic_vector(SF_SEGPOS_LEN-1 downto 0);     -- 16
    -- SF MDT segment angle along the precision coord
    segangle   : std_logic_vector(SF_SEGANGLE_LEN-1 downto 0);   -- 10
    -- SF MDT segment qualiry
    segquality : std_logic;
  end record sf_rt;

  -- -----------------------------------------------------------------
  subtype PTCALC_at is std_logic_vector(53 downto 0);

  type ptcalc_rt is record
    -- struct SLC_MUID
    slc_muid_r : SLC_MUID_rt;
    -- eta of the innermost MDT station segment position
    eta        : std_logic_vector(PTCALC_ETA_LEN-1 downto 0);        -- 14
    -- pT calculated by the pT Calc
    pt         : std_logic_vector(PTCALC_PT_LEN-1 downto 0);         -- 8
    -- pT threshold satisfied by the MDT TC
    ptthresh   : std_logic_vector(PTCALC_PTTHRESH_LEN-1 downto 0);   -- 3
    -- charge determined from the pT calc
    charge     : std_logic;
    -- # of segments used for calculating the pT
    nsegments  : std_logic_vector(PTCALC_NSEGMENTS_LEN-1 downto 0);  -- 1
    -- quality of the MDT TC (TBC how this is defined)
    quality    : std_logic_vector(PTCALC_QUALITY_LEN-1 downto 0);    -- 2
  end record ptcalc_rt;

  -- -----------------------------------------------------------------
  subtype SLCPIPE_MTC_ENDCAP_at is std_logic_vector(54 downto 0);

  type slcpipe_mtc_endcap_rt is record
    -- struct SLC_MUID
    slc_muid_r   : SLC_MUID_rt;
    -- struct SLC_COMMON
    slc_common_r : SLC_COMMON_rt;
    -- (COPY)
    busy         : std_logic;
    -- (COPY)
    destsl       : std_logic_vector(SLCPIPE_MTC_ENDCAP_DESTSL_LEN-1 downto 0);  -- 1
  end record slcpipe_mtc_endcap_rt;

  -- -----------------------------------------------------------------
  subtype SLCPIPE_MTC_BARREL_at is std_logic_vector(57 downto 0);

  type slcpipe_mtc_barrel_rt is record
    -- (COPY)
    cointype     : std_logic_vector(SLCPIPE_MTC_BARREL_COINTYPE_LEN-1 downto 0);  -- 2
    -- struct SLC_MUID
    slc_muid_r   : SLC_MUID_rt;
    -- struct SLC_COMMON
    slc_common_r : SLC_COMMON_rt;
    -- (COPY)
    busy         : std_logic;
    -- (COPY)
    destsl       : std_logic_vector(SLCPIPE_MTC_BARREL_DESTSL_LEN-1 downto 0);  -- 1
  end record slcpipe_mtc_barrel_rt;

  -- -----------------------------------------------------------------
  subtype MTC_at is std_logic_vector(69 downto 0);

  type mtc_rt is record
    -- struct SLC_COMMON
    slc_common_r : SLC_COMMON_rt;
    -- (COPY)
    eta          : std_logic_vector(MTC_ETA_LEN-1 downto 0);        -- 14
    -- (COPY)
    pt           : std_logic_vector(MTC_PT_LEN-1 downto 0);         -- 8
    -- (COPY)
    ptthresh     : std_logic_vector(MTC_PTTHRESH_LEN-1 downto 0);   -- 3
    -- (COPY)
    charge       : std_logic;
    -- MDT processing flags
    procflags    : std_logic_vector(MTC_PROCFLAGS_LEN-1 downto 0);  -- 3
    -- (COPY)
    nsegments    : std_logic_vector(MTC_NSEGMENTS_LEN-1 downto 0);  -- 1
    -- (COPY)
    quality      : std_logic_vector(MTC_QUALITY_LEN-1 downto 0);    -- 2
  end record mtc_rt;

-- -------------------------------------------------------------------

end package mdttp_types_pkg;
