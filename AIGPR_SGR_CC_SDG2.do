* ============================================================
* Fragmented Geopolitics, Restricted Capital, and Zero Hunger: Global Evidence on SDG 2 Progress   
* By Nian Zhang, Khadim Hussain,Saleh A. Aljamaan, et at (2026)
* ========================================================

* ========Step1:Load the data====================================

clear all

use  "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\final-transformed_data.dta"
xtset id Year
log using estimation


 
* ========Step 2:Descriptive statistics and correlation=========

asdoc sum l_Undernsh l_Stunting  l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP,append
asdoc pwcorr l_Undernsh l_Stunting  l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP,append



sum2docx l_Undernsh l_Stunting  l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP using  "D:\Research 2023-24\2026\Energy Trilemma, SGR, and AIGR and CC\Date\Replication\results\Table 2.docx",replace stats(N mean(%9.3f) sd(%9.3f) min(%9.3f) max(%9.3f))  title("Table 2:Descriptive statistics")




* ============================================================
* STEP 3: Pre-Estimation Diagnostic Tests
* ========================================================
*Table A2 and A3 it may take about more than 30 minuts
log using xtpretest,replace

xtpretest l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP
xtpretest l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP
xtpretest l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP

xtpretest l_Stunting l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP
xtpretest l_Stunting SGR l_GDP l_DCP l_AGR ihs_INF1 POP
xtpretest l_Stunting CC l_GDP l_DCP l_AGR ihs_INF1 POP

log close

*===============* STEP 4: Baseline analysis Table 3============

set seed 12345
//Panel A Panel A: Driscoll-Kraay results
eststo clear
*Undernsh
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP,  lag(8)
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP,  lag(8) 

*Stunting
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP, lag(8)
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP,  lag(8) 


estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc",  title(Table 3A: Effects of AIGPR, SGR, and CC on SDG2 [Baseline Driscoll-Kraay results]) se label rtf b(3) scalars( N r2 ) replace ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") order(l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP) nogap 
eststo clear


//Panel B:xtpcse results

eststo clear
*Undernsh
eststo: xtpcse l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
eststo: xtpcse l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
eststo: xtpcse l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
*Stunting
eststo: xtpcse l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
eststo: xtpcse l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
eststo: xtpcse l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP, rhotype(dw) np1 
estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 3B: Effects of AIGPR, SGR, and CC on SDG2 [Baseline PCSE results]) se label rtf b(3) scalars( N r2 )  append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") order(l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP) nogap 
eststo clear
*===========================================================================
****-Step 5 : Heterogenity analysis  -****
*===========================================================================
* By region Table 4
/*
Middle East, North Africa, Afghanistan & Pakistan=1
Sub-Saharan Africa=2
Europe & Central Asia=3
Latin America & Caribbean=4
East Asia & Pacific=5
South Asia=6
North America=7
*/

unique id if region==7
*1-Impact of AIGPR on SDG2(Undernsh,Stunting) 
eststo clear
*Undernsh
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==1,  lag(8) 
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8)
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==4,  lag(8) 
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8)
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8)

*Stunting
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==1, lag(8)
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8) 
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==4, lag(8)
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8) 
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8) 

estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 4 (Section 1): Effects of AIGPR on SDG2 by region[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)"  "(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) order(l_AIPGR1) keep(l_AIPGR1) nogap 
eststo clear

*1-Impact of SGR on SDG2(Undernsh,Stunting) by region
*Undernsh
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==1,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8)
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==4,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8)
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8)

*Stunting
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==1, lag(8)
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8) 
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==4, lag(8)
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8) 
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8) 


estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 4 (section II): Effects of SGR on SDG2 by region[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)"  "(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) order(SGR) keep(SGR) nogap 
eststo clear

*1-Impact of CC on SDG2(Undernsh,Stunting) by region
*Undernsh
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==1,  lag(8) 
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8)
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==4,  lag(8) 
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8)
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8)

*Stunting
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==1, lag(8)
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==2,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==3,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==4, lag(8)
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==5,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if region==6,  lag(8) 



estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 4 (section III): Effects of CC on SDG2 by region[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)"  "(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) order(CC) keep(CC) nogap 
eststo clear


*1-Impact of AIPGR on SDG2(Undernsh,Stunting) by income
*Undernsh
eststo clear
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if income==1,  lag(8) 
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8)
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Undernsh l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP if income==4,  lag(8) 

*Stunting
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if income==1, lag(8)
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8) 
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Stunting  l_AIPGR1  l_GDP l_DCP l_AGR ihs_INF1 POP if income==4, lag(8)


estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 5 (Part I): Effects of AIGPR on SDG2 by income[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(1)" "(2)" "(3)" "(4)") order(l_AIPGR1) keep(l_AIPGR1) nogap 
eststo clear
*1-Impact of SGR on SDG2(Undernsh,Stunting) by income
eststo clear
*Undernsh
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if income==1,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8)
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Undernsh SGR l_GDP l_DCP l_AGR ihs_INF1 POP if income==4,  lag(8) 
*Stunting
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if income==1, lag(8)
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8) 
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Stunting  SGR  l_GDP l_DCP l_AGR ihs_INF1 POP if income==4, lag(8)
estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 5 (Part II): Effects of SGR on SDG2 by income[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(1)" "(2)" "(3)" "(4)") order(SGR) keep(SGR) nogap 
eststo clear

//*1-Impact of CC on SDG2(Undernsh,Stunting) by income
eststo clear
*Undernsh
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if income==1,  lag(8) 
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8)
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Undernsh CC l_GDP l_DCP l_AGR ihs_INF1 POP if income==4,  lag(8) 
*Stunting
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if income==1, lag(8)
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if income==2,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if income==3,  lag(8) 
eststo: xtscc l_Stunting  CC  l_GDP l_DCP l_AGR ihs_INF1 POP if income==4, lag(8)


estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 5 (Part III): Effects of CC on SDG2 by income[Heterogeneity results]) se label rtf b(3) scalars( N r2 ) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(1)" "(2)" "(3)" "(4)") order(CC) keep(CC) nogap 
eststo clear


			  
*===========================================================================
****-Robustness by MMQR  -****
*===========================================================================
**# **# Table 6

eststo clear
*Undernsh
eststo:mmqreg l_Undernsh  l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(Year) // 
eststo:mmqreg l_Undernsh  SGR l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(Year) // 
eststo:mmqreg l_Undernsh  CC l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(Year) // 
*Stunting
eststo:mmqreg l_Stunting  l_AIPGR1 l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(Year) // 
eststo:mmqreg l_Stunting  SGR l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(id) // 
eststo:mmqreg l_Stunting  CC l_GDP l_DCP l_AGR ihs_INF1 POP, robust q(10,25,50,75,90) absorb(Year) // 

estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 6: Effects of AIGPR, SGR, and CC on SDG2, MMQR results) se label rtf b(3) scalars( N r2)  append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)") order(l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP) nogap 
eststo clear

**Table 7: Robustness by IV/2SLS GMM 
eststo clear
*Undernsh
eststo: ivreg2 l_Undernsh  l_GDP l_DCP l_AGR ihs_INF1 POP (l_AIPGR1 = l.l_AIPGR1), gmm2s first robust
eststo: ivreg2 l_Undernsh  l_GDP l_DCP l_AGR ihs_INF1 POP (SGR =l.SGR), gmm2s first robust
eststo: ivreg2 l_Undernsh  l_GDP l_DCP l_AGR ihs_INF1 POP (CC =l.CC), gmm2s first robust
*Stunting
eststo: ivreg2 l_Stunting  l_GDP l_DCP l_AGR ihs_INF1 POP (l_AIPGR1 =l.l_AIPGR1), gmm2s first robust
eststo: ivreg2 l_Stunting  l_GDP l_DCP l_AGR ihs_INF1 POP (SGR =l.SGR), gmm2s first robust
eststo: ivreg2 l_Stunting  l_GDP l_DCP l_AGR ihs_INF1 POP (CC =l.CC), gmm2s first robust

estout, cells(b(star fmt(3)) se(par fmt(3)) ) stats(N r2 , fmt(3 3 0))  starlevels(* 0.10 ** 0.05 *** 0.01)         
esttab using "D:\Submissions\2026\AIGPR, SGR,CC and SDG2\replication\Tables rj.doc", title(Table 7 : IV/2SLS Two-step GMM with robust SEs results]) se label rtf b(3) scalars(N  idstat idp widstat) append ///
star(* 0.10 ** 0.05 *** 0.01) se(3) nonumber mti ("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) order(l_AIPGR1 SGR CC l_GDP l_DCP l_AGR ihs_INF1 POP) 
eststo clear
log close

*******************The End***********************************************






