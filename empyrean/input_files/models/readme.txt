      readme.txt                   .... This file!
      model.lib                          .... Corner values for MOSFETs, BJT, resistors and varactor
      mos_diode.mdl                          .... Model parameters file for N/PMOS and diode
      BJT.mdl                      .... Model parameters file for BJT
      res.mdl                      .... Model parameters file for resistors
      res.ckt                      .... Resistor and varactor macro model 

How to use SPICE models in Aeolus:

      Add the following statements to Aeolus netlist.
      
      a. Specify MOS, BJT, diode, resistor corner and model by the '.lib' statement;

         .lib '/xxx/xxx/model.lib' TT
                                       ^^ mos model corner

         .lib '/xxx/xxx/model.lib' BJT_TT
                                           ^^ bjt model corner

         .lib '/xxx/xxx/model.lib' RES_TT
                                           ^^ resistor model corner

      b. Call resistor macro model subcircuit by the following statement;
         
         .lib '/xxx/xxx/model.lib' TT
                                       ^^ mos model corner

         .lib '/xxx/xxx/model.lib' RES_TT
                                           ^^ resistor model corner

         .include '/xxx/xxx/res.ckt'
          
         then add the following statement in your netlist to define subcircuit condition
         you want to simulate. 

         e.g. nwell resistor under STI       
              X1  rnw_ckt w=1u l=1u

         Note: For metal resistor, don't need to use the subcircuit file 
               '/xxx/xxx/res.ckt'.
                          
      c. Call N+poly/NW MOS varactor model by the following statement;

         .lib '/xxx/xxx/model.lib' VAR_TT
                                           ^^ varactor model corner

         .include '/xxx/xxx/res.ckt'    
         
         then add the following statement in your netlist to define subcircuit condition
         you want to simulate.
         
         e.g. XCKT 1 2 pvar18_ckt lr=1u wr=10u nf=10  

         Where /xxx/xxx is the directory where mdl and lib files are located.    


The Capability of Model

	a. MOS Model 
	
        *---------------------------------------------* 
        |     MOSFET type    |  name  | Lmin  | Wmin  |
        |=============================================| 
        |   1.8V NMOS        |  n18   |0.18um |0.22um |
        *---------------------------------------------*
        |   1.8V PMOS        |  p18   |0.18um |0.22um |
        *---------------------------------------------*
        temperature range:-40C~125C
   
	b. BJT Model

        *---------------------------------------------------* 
        |      BJT type     |     name      |  Emitter Area |
        |===================================================|
        |   1.8V PNP_10X10  |   pnp18a100   |   10*10 um^2  |
        *---------------------------------------------------*  
        |   1.8V PNP_5X5    |   pnp18a25    |   5*5 um^2    |
        *---------------------------------------------------* 
        |   1.8V PNP_2X2    |   pnp18a4     |   2*2 um^2    |
        *---------------------------------------------------* 
        |   3.3V PNP_10X10  |   pnp33a100   |   10*10 um^2  |
        *---------------------------------------------------*  
        |   3.3V PNP_5X5    |   pnp33a25    |   5*5 um^2    |
        *---------------------------------------------------* 
        |   3.3V PNP_2X2    |   pnp33a4     |   2*2 um^2    |
        *---------------------------------------------------* 
        temperature range:-40C~125C
         
	c. Diode Model               
	
        *---------------------------------------------* 
        |      Diode type      |  name   |    Area    |
        |=============================================| 
        |    1.8V N+/PWELL     | ndio18  | 60*60 um^2 |
        *---------------------------------------------*
        |    1.8V P+/NWELL     | pdio18  | 60*60 um^2 |
        *---------------------------------------------*
        |      NWELL/PSUB      |  nwdio  | 80*120 um^2|	
	*---------------------------------------------*	
	temperature range:-40C~125C

	d. Resistor Model
	
        *----------------------------------------------------------------------* 
        |             Resistor Type                            |     name      |
        |======================================================|===============|
        |        Silicide N+ Diffusion                         |    rndif      |
        |------------------------------------------------------|---------------| 
        |        Silicide P+ Diffusion                         |    rpdif      |
        |------------------------------------------------------|---------------| 
        |           Silicide N+ Poly                           |     rnpo      |
        |----------------------------------------------------  |---------------| 
        |           Silicide P+ Poly                           |     rppo      |
        |------------------------------------------------------|---------------| 
        |                  Metal 1                             |      rm1      |
        |------------------------------------------------------|---------------| 
        |                  Metal 2                             |      rm2      |
        |------------------------------------------------------|---------------| 
        |                  Metal 3                             |      rm3      |
        |------------------------------------------------------|---------------|  
        |                  Metal 4                             |      rm4      |
        |------------------------------------------------------|---------------| 
        |                  Metal 5                             |      rm5      |
        |------------------------------------------------------|---------------| 
        temperature range:-40C~125C
        For more detailed information, please refer to the main document in section 7.6.


Corner Model

   Five model corners are provided for MOSFETs, 
   three model corners are provided for BJT, 
   three model corners are provided for resistors.
   three model corners are provided for varactor.

   They are

      ----------------------------------------------------
      MOS          name : corner
      ----------------------------------------------------
                     TT : Typical case 
                     SS : Slow case
                     FF : Fast case
                   SNFP : Slow N Fast P case 
                   FNSP : Fast N Slow P case 
      ----------------------------------------------------
      BJT          name : corner
      ----------------------------------------------------
                 BJT_TT : Typical case
                 BJT_SS : Slow case
                 BJT_FF : Fast case 
      ----------------------------------------------------
      Resistor     name : corner
      ----------------------------------------------------
                 RES_TT : Typical case
                 RES_SS : Slow case
                 RES_FF : Fast case
      ----------------------------------------------------
      Varactor     name : corner
      ----------------------------------------------------
                 VAR_TT : Typical case
                 VAR_SS : Slow case
                 VAR_FF : Fast case 
      ----------------------------------------------------
