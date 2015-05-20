[Mesh]
  type = FileMesh
  file = ../../meshes/Cylinder_hollow_3reg.msh
[]

[MeshModifiers]
  [./point1]
    type = AddExtraNodeset
    boundary = 6
    coord = '0.3 0 1'
  [../]
[]

[Variables]
  [./disp_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./disp_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temp]
  [../]
  [./pore_pressure]
  [../]
[]

[Materials]
  [./mat_mech]
    type = RedbackMechMaterial
    block = 1
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    exponent = 3
    C_ijkl = '1.346e+03 5.769e+02 5.769e+02 1.346e+03 5.769e+02 1.346e+03 3.846e+02 3.846e+02 3.846e+2'
    ref_pe_rate = 1
    slope_yield_surface = -0.8
    yield_criterion = modified_Cam_Clay
    yield_stress = '0. 1 1. 1'
  [../]
  [./mat_nomech]
    type = RedbackMaterial
    block = 1
    is_chemistry_on = true
    is_mechanics_on = false
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    alpha_2 = 3
    mu = 1
    ar = 12
    gr = 50
    ref_lewis_nb = 1
    Kc = 1
    ar_F = 24
    ar_R = 12
    phi0 = 0.1
    Aphi = 1
    eta2 = 1e4
    da_exo = 1e-3
  [../]
  [./inner_ring_mech]
    type = RedbackMechMaterial
    block = 0
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    exponent = 3
    C_ijkl = '1.346e+03 5.769e+02 5.769e+02 1.346e+03 5.769e+02 1.346e+03 3.846e+02 3.846e+02 3.846e+2'
    ref_pe_rate = 1
    yield_criterion = elasticity
    yield_stress = '0. 100 1. 100'
  [../]
  [./inner_ring_nomech]
    type = RedbackMaterial
    block = 0
    is_chemistry_on = true
    is_mechanics_on = false
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    alpha_2 = 3
    mu = 1
    ar = 12
    gr = 50
    ref_lewis_nb = 1
    Kc = 1
    ar_F = 24
    ar_R = 12
    phi0 = 0.1
    Aphi = 1
    eta2 = 1e4
    da_exo = 1e-3
    solid_thermal_expansion = 1e-2
  [../]
  [./outer_ring_mech]
    type = RedbackMechMaterial
    block = 2
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    exponent = 3
    C_ijkl = '1.346e+03 5.769e+02 5.769e+02 1.346e+03 5.769e+02 1.346e+03 3.846e+02 3.846e+02 3.846e+2'
    ref_pe_rate = 1
    yield_criterion = elasticity
    yield_stress = '0. 100 1. 100'
  [../]
  [./outer_ring_nomech]
    type = RedbackMaterial
    block = 2
    is_chemistry_on = true
    is_mechanics_on = false
    disp_x = disp_x
    disp_y = disp_y
    disp_z = disp_z
    pore_pres = pore_pressure
    temperature = temp
    alpha_2 = 3
    mu = 1
    ar = 12
    gr = 50
    ref_lewis_nb = 1
    Kc = 1
    ar_F = 24
    ar_R = 12
    phi0 = 0.1
    Aphi = 1
    eta2 = 1e4
    da_exo = 1e-3
    solid_thermal_expansion = 1e-3
  [../]
[]

[Functions]
  active = 'upfunc downfunc'
  [./upfunc]
    type = ParsedFunction
    value = 1+t
  [../]
  [./downfunc]
    type = ParsedFunction
    value = -1*t
  [../]
  [./spline_IC]
    type = ConstantFunction
  [../]
[]

[BCs]
  active = 'inside_outside_temp bottom_fix_x bottom_fix_y bottom_fix_z top_fix_x top_fix_z top_fix_y outer_pressure'
  [./temp_box]
    type = NeumannBC
    variable = temp
    boundary = '0 1 2 3 4 5'
  [../]
  [./back_fix_z]
    type = NeumannBC
    variable = disp_z
    boundary = 0
  [../]
  [./right_fix_x]
    type = DirichletBC
    variable = disp_z
    boundary = right
    value = 0
  [../]
  [./bottom_fix_y]
    type = DirichletBC
    variable = disp_y
    boundary = 1
    value = 0
  [../]
  [./constant_y_velocity_top]
    type = FunctionPresetBC
    variable = disp_y
    boundary = top
    function = downfunc
  [../]
  [./bottom_fix_x]
    type = DirichletBC
    variable = disp_x
    boundary = 1
    value = 0
  [../]
  [./bottom_fix_z]
    type = DirichletBC
    variable = disp_z
    boundary = 1
    value = 0
  [../]
  [./top_fix_z]
    type = DirichletBC
    variable = disp_z
    boundary = 0
    value = 0
  [../]
  [./drained_top_bottom]
    type = DirichletBC
    variable = pore_pressure
    boundary = '1 3'
    value = 0
  [../]
  [./inner_pressure]
    type = DirichletBC
    variable = pore_pressure
    boundary = 3
    value = 0.9
  [../]
  [./outer_pressure]
    type = DirichletBC
    variable = pore_pressure
    boundary = 2
    value = 0
  [../]
  [./constant_force_inner_x]
    type = NeumannBC
    variable = disp_x
    boundary = 3
    value = 1.5
  [../]
  [./constant_force_inner_y]
    type = NeumannBC
    variable = disp_y
    boundary = 3
    value = 1.5
  [../]
  [./outer_x]
    type = DirichletBC
    variable = disp_x
    boundary = 2
    value = 0
  [../]
  [./outer_y]
    type = DirichletBC
    variable = disp_y
    boundary = 2
    value = 0
  [../]
  [./top_fix_x]
    type = DirichletBC
    variable = disp_x
    boundary = 0
    value = 0
  [../]
  [./top_fix_y]
    type = DirichletBC
    variable = disp_y
    boundary = 0
    value = 0
  [../]
  [./outside_temp]
    type = DirichletBC
    variable = temp
    boundary = '2'
    value = 1
  [../]
   [./inside_temp]
    type = FunctionPresetBC
    variable = temp
    boundary = '3'
    function = upfunc
  [../]
[]

[AuxVariables]
  active = 'Mod_Gruntfest_number solid_ratio mises_strain mech_diss mises_strain_rate volumetric_strain_rate mises_stress volumetric_strain mean_stress Lewis_number porosity'
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./peeq]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pe33]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_strain]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mises_strain_rate]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mech_diss]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./Mod_Gruntfest_number]
    order = CONSTANT
    family = MONOMIAL
    block = '0 1'
  [../]
  [./volumetric_strain]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./volumetric_strain_rate]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mean_stress]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./porosity]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./Lewis_number]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./solid_ratio]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./td_temp]
    type = TimeDerivative
    variable = temp
    block = '0 1 2'
  [../]
  [./temp_diff]
    type = Diffusion
    variable = temp
    block = '0 1 2'
  [../]
  [./temp_dissip]
    type = RedbackMechDissip
    variable = temp
    block = '0 1 2'
  [../]
  [./temp_endo_chem]
    type = RedbackChemEndo
    variable = temp
    block = '0 1 2'
  [../]
  [./td_press]
    type = TimeDerivative
    variable = pore_pressure
    block = '0 1 2'
  [../]
  [./press_diff]
    type = RedbackMassDiffusion
    variable = pore_pressure
    block = '0 1 2'
  [../]
  [./chem_press]
    type = RedbackChemPressure
    variable = pore_pressure
    block = '0 1 2'
  [../]
[]

[AuxKernels]
  active = 'volumetric_strain solid_ratio mises_strain Lewis_number mises_strain_rate volumetric_strain_rate mises_stress mean_stress mech_dissipation porosity Gruntfest_Number'
  [./stress_zz]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_zz
    index_i = 2
    index_j = 2
  [../]
  [./pe11]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe11
    index_i = 0
    index_j = 0
  [../]
  [./pe22]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe22
    index_i = 1
    index_j = 1
  [../]
  [./pe33]
    type = RankTwoAux
    rank_two_tensor = plastic_strain
    variable = pe33
    index_i = 2
    index_j = 2
  [../]
  [./eqv_plastic_strain]
    type = FiniteStrainPlasticAux
    variable = peeq
  [../]
  [./mises_stress]
    type = MaterialRealAux
    variable = mises_stress
    property = mises_stress
  [../]
  [./mises_strain]
    type = MaterialRealAux
    variable = mises_strain
    property = eqv_plastic_strain
  [../]
  [./mises_strain_rate]
    type = MaterialRealAux
    variable = mises_strain_rate
    block = 0
    property = mises_strain_rate
  [../]
  [./mech_dissipation]
    type = MaterialRealAux
    variable = mech_diss
    property = mechanical_dissipation
  [../]
  [./Gruntfest_Number]
    type = MaterialRealAux
    variable = Mod_Gruntfest_number
    property = mod_gruntfest_number
    block = 0
  [../]
  [./mean_stress]
    type = MaterialRealAux
    variable = mean_stress
    property = mean_stress
    block = 0
  [../]
  [./volumetric_strain]
    type = MaterialRealAux
    variable = volumetric_strain
    property = volumetric_strain
  [../]
  [./volumetric_strain_rate]
    type = MaterialRealAux
    variable = volumetric_strain_rate
    property = volumetric_strain_rate
  [../]
  [./porosity]
    type = MaterialRealAux
    variable = porosity
    property = porosity
    block = 0
  [../]
  [./Lewis_number]
    type = MaterialRealAux
    variable = Lewis_number
    property = lewis_number
  [../]
  [./solid_ratio]
    type = MaterialRealAux
    variable = solid_ratio
    property = solid_ratio
  [../]
[]

[Postprocessors]
  [./mises_stress]
    type = PointValue
    variable = mises_stress
    point = '0.3 0 1'
  [../]
  [./mises_strain]
    type = PointValue
    variable = mises_strain
    point = '0.3 0 1'
  [../]
  [./mises_strain_rate]
    type = PointValue
    variable = mises_strain_rate
    point = '0.3 0 1'
  [../]
  [./temp_middle]
    type = PointValue
    variable = temp
    point = '0.3 0 1'
  [../]
  [./mean_stress]
    type = PointValue
    variable = mean_stress
    point = '0.3 0 1'
  [../]
  [./volumetric_strain]
    type = PointValue
    variable = volumetric_strain
    point = '0.3 0 1'
  [../]
  [./volumetric_strain_rate]
    type = PointValue
    variable = volumetric_strain_rate
    point = '0.3 0 1'
  [../]
  [./middle_press]
    type = PointValue
    variable = pore_pressure
    point = '0.3 0 1'
  [../]
  [./porosity_middle]
    type = PointValue
    variable = porosity
    point = '0.3 0 1'
  [../]
  [./Lewis_middle]
    type = PointValue
    variable = Lewis_number
    point = '0.3 0 1'
  [../]
  [./solid_ratio_middle]
    type = PointValue
    variable = solid_ratio
    point = '0.3 0 1'
  [../]
[]

[Preconditioning]
  # active = ''
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  start_time = 0.0
  end_time = 1
  dtmax = 1
  dtmin = 1e-7
  type = Transient
  l_max_its = 200
  nl_max_its = 10
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type -snes_linesearch_type -ksp_gmres_restart'
  petsc_options_value = 'hypre boomeramg cp 201'
  nl_abs_tol = 1e-10 # 1e-10 to begin with
  reset_dt = true
  line_search = basic
  [./TimeStepper]
    type = ConstantDT
    dt = 1e-4
  [../]
[]

[Outputs]
  file_base = borehole_CC
  output_initial = true
  exodus = true
  [./console]
    type = Console
    perf_log = true
    linear_residuals = true
  [../]
[]

[RedbackMechAction]
  [./solid]
    disp_z = disp_z
    disp_y = disp_y
    disp_x = disp_x
    temp = temp
    pore_pres = pore_pressure
  [../]
[]

[ICs]
  [./temp_IC]
    variable = temp
    type = RandomIC
  [../]
  [./press_IC]
    variable = pore_pressure
    type = ConstantIC
    value = 0
  [../]
[]

