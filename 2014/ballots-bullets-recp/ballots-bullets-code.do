* Do-file for "Between Ballots and Bullets: Executive Competitiveness and Civil War Incidence, 1976-2000"
* Danilo Freire
* (Stata 12)

* Table 1 - Descriptive statistics
summarize ucdp_incidence p_xrcomp0_t1 p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 dpi_eipc2_t1 dpi_eipc3_t1 dpi_eipc4_t1 dpi_eipc6_t1 dpi_eipc7_t1 dpi_eipc_n_t1 dpi_eipc_p_t1 van_comp_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, separator (0)

* Table 2 - Logistic Regressions
* Model I 
logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog

* Model II
logit ucdp_incidence dpi_eipc3_t1 dpi_eipc4_t1 dpi_eipc6_t1 dpi_eipc7_t1 dpi_eipc_n_t1 dpi_eipc_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog

* Model III
logit ucdp_incidence van_comp_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog

* Post-estimation analyses with Clarify
* Installation 
net from http://gking.harvard.edu/clarify
net install clarify

* Generating quantities of interest for the Model I
* Polity IV

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 1 p_xrcomp2_t1 0 p_xrcomp3_t1 0 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0 p_xrcomp2_t1 1 p_xrcomp3_t1 0 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13


estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0 p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13

* Generating quantities of interest for Model II
* DPI

estsimp logit ucdp_incidence dpi_eipc3_t1 dpi_eipc4_t1 dpi_eipc6_t1 dpi_eipc7_t1 dpi_eipc_n_t1 dpi_eipc_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx dpi_eipc3_t1 1 dpi_eipc4_t1 0 dpi_eipc6_t1 0 dpi_eipc7_t1 0  dpi_eipc_n_t1 0 dpi_eipc_p_t1 0 no_ufs_t1 1
simqi, prval(1)

estsimp logit ucdp_incidence dpi_eipc3_t1 dpi_eipc4_t1 dpi_eipc6_t1 dpi_eipc7_t1 dpi_eipc_n_t1 dpi_eipc_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx dpi_eipc3_t1 0 dpi_eipc4_t1 0 dpi_eipc6_t1 1 dpi_eipc7_t1 0  dpi_eipc_n_t1 0 dpi_eipc_p_t1 0 no_ufs_t1 1
simqi, prval(1)

estsimp logit ucdp_incidence dpi_eipc3_t1 dpi_eipc4_t1 dpi_eipc6_t1 dpi_eipc7_t1 dpi_eipc_n_t1 dpi_eipc_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx dpi_eipc3_t1 0 dpi_eipc4_t1 0 dpi_eipc6_t1 1 dpi_eipc7_t1 0  dpi_eipc_n_t1 0 dpi_eipc_p_t1 0 no_ufs_t1 1
simqi, prval(1)
setx median
setx dpi_eipc3_t1 0 dpi_eipc4_t1 0 dpi_eipc6_t1 1 dpi_eipc7_t1 0  dpi_eipc_n_t1 1 dpi_eipc_p_t1 0 no_ufs_t1 1
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14


* Generating quantities of interest for Model III
* Vanhanen

estsimp logit ucdp_incidence van_comp_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx van_comp_t1 0 no_ufs_t1 1
simqi, prval(1)
setx median
setx van_comp_t1 70 no_ufs_t1 0
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9


* Ethnic fractionalisation

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx r_atlas 0
simqi, prval(1)
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx r_atlas .93
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13

* Large Population

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx ln_unna_pop_t1 16.115
simqi, prval(1)
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx ln_unna_pop_t1 18.42
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13

* Economic growth

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx  unna_grgdp_t1 -5
simqi, prval(1)
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx  unna_grgdp_t1 5
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13


* GDP per capita

estsimp logit ucdp_incidence p_xrcomp1_t1 p_xrcomp2_t1 p_xrcomp3_t1 p_xrcomp_n_t1 p_xrcomp_p_t1 no_ufs_t1 r_atlas oil_t1 lmtnest ln_unna_pop_t1 unna_grgdp_t1 unna_gdpc_t1, robust nolog
setx median
setx p_xrcomp1_t1 0  p_xrcomp2_t1 0 p_xrcomp3_t1 1 p_xrcomp_n_t1 0 p_xrcomp_p_t1 0 no_ufs_t1 1
setx unna_gdpc_t1 .054 * 10% percentile
simqi, prval(1)
setx unna_gdpc_t1 63.94 * 90% percentile
simqi, prval(1)
drop b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13


