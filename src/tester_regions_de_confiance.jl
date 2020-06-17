using Test

"""
Tester l'algorithme des régions de confiance

#Entrées :
   * affichage : (Bool) affichage ou non des résultats de chaque test

"""

function tester_regions_de_confiance(afficher,Regions_De_Confiance::Function)

	"#initialisation des variables de l'algorithme"
	tolG = 1e-5
	gamma1 = 0.5
	gamma2 = 2.00
	eta1 = 0.25
	eta2 = 0.75
	deltaMax = 1
	tol = 1e-8
	maxits = 5000
	delta0_1 = 2
	delta0_2 = 1
	eps = 1e-8

	options1 =[deltaMax,gamma1,gamma2,eta1,eta2,delta0_1,maxits,tol,eps]
	options2 =[deltaMax,gamma1,gamma2,eta1,eta2,delta0_2,maxits,tol,eps]


	tol_erreur = 1e-2

	"#test avec la fonction f1 et point initial x011"
	RC_x_min11, RC_fmin11, RC_flag11, RC_nb_iters11 = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x011,options1)
	#affichage des résultats du test
	if (afficher)
		afficher_resultats("régions de confiance avec "*"cauchy","fonction 1","x011",RC_x_min11,RC_fmin11, RC_flag11,sol_exacte_fct1,RC_nb_iters11)
	end


	"#test avec la fonction f1 et point initial x012"
	RC_x_min12, RC_fmin12, RC_flag12, RC_nb_iters12  = Regions_De_Confiance("cauchy",fct1,grad_fct1,hess_fct1,pts1.x012,options1)	
	if (afficher)
		afficher_resultats("régions de confiance avec "*"cauchy","fonction 1","x012",RC_x_min12,RC_fmin12, RC_flag11,sol_exacte_fct1,RC_nb_iters12)
	end

	"#test avec la fonction f2 et point initial x021"
	RC_x_min21, RC_fmin21, RC_flag21, RC_nb_iters21,  = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x021,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"cauchy","fonction 2","x021",RC_x_min21,RC_fmin21, RC_flag21,sol_exacte_fct2,RC_nb_iters21)
	end

	"#test avec la fonction f2 et point initial x022"
	RC_x_min22, RC_fmin22, RC_flag22, RC_nb_iters22 = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x022,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"cauchy","fonction 2","x022",RC_x_min22,RC_fmin22, RC_flag22,sol_exacte_fct2,RC_nb_iters22)
	end

	"#test avec la fonction f2 et point initial x023"
	RC_x_min23, RC_fmin23, RC_flag23, RC_nb_iters23 = Regions_De_Confiance("cauchy",fct2,grad_fct2,hess_fct2,pts1.x023,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"cauchy","fonction 2","x023",RC_x_min23,RC_fmin23, RC_flag23,sol_exacte_fct2,RC_nb_iters23)
	end

	"#test avec la fonction f1 et point initial x011"
	gct_x_min11, RC_fmin11, RC_flag11, RC_nb_iters11= Regions_De_Confiance("gct",fct1,grad_fct1,hess_fct1,pts1.x011,options1)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"gct","fonction 1","x011",RC_x_min11,RC_fmin11, RC_flag11,sol_exacte_fct1,RC_nb_iters11)
	end

	"#test avec la fonction f1 et point initial x012"
	gct_x_min12, RC_fmin12, RC_flag12, RC_nb_iters12 = Regions_De_Confiance("gct",fct1,grad_fct1,hess_fct1,pts1.x012,options1)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"gct","fonction 1","x012",RC_x_min12,RC_fmin12, RC_flag12,sol_exacte_fct1,RC_nb_iters12)
	end

	"#test avec la fonction f2 et point initial x021"
	gct_x_min21, RC_fmin21, RC_flag21, RC_nb_iters21 = Regions_De_Confiance("gct",fct2,grad_fct2,hess_fct2,pts1.x021,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"gct","fonction 2","x021",RC_x_min21,RC_fmin21, RC_flag21,sol_exacte_fct2,RC_nb_iters21)
	end

	"#test avec la fonction f2 et point initial x022"
	gct_x_min22, RC_fmin22, RC_flag22, RC_nb_iters22 = Regions_De_Confiance("gct",fct2,grad_fct2,hess_fct2,pts1.x022,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"gct","fonction 2","x022",RC_x_min22,RC_fmin22, RC_flag22,sol_exacte_fct2,RC_nb_iters22)
	end

	"#test avec la fonction f2 et point initial x023"
	gct_x_min23, RC_fmin23, RC_flag23, RC_nb_iters23 = Regions_De_Confiance("gct",fct2,grad_fct2,hess_fct2,pts1.x023,options2)
	if (afficher)
		afficher_resultats("régions de confiance avec "*"gct","fonction 2","x023",RC_x_min11,RC_fmin23, RC_flag23,sol_exacte_fct2,RC_nb_iters23)
	end

	"#tester les résultats obtenues"
	res = @testset "La méthode des régions de confiance " begin 
		res = @testset "régions de confiance avec le pas de cauchy " begin 
		   @test isapprox(RC_x_min11,sol_exacte_fct1 ,atol=tol_erreur)
		   @test RC_x_min12 ≈ sol_exacte_fct1 atol=tol_erreur
		   @test RC_x_min21 ≈ sol_exacte_fct2 atol=tol_erreur
		   @test RC_x_min22 ≈ sol_exacte_fct2 atol=tol_erreur
		   @test RC_x_min23 ≈ sol_exacte_fct2 atol=tol_erreur
		end

		res = @testset "régions de confiance avec le gradient conjugué tronqué " begin 
		   @test isapprox(gct_x_min11,sol_exacte_fct1 ,atol=tol_erreur)
		   @test gct_x_min12 ≈ sol_exacte_fct1 atol=tol_erreur
		   @test gct_x_min21 ≈ sol_exacte_fct2 atol=tol_erreur
		   @test gct_x_min22 ≈ sol_exacte_fct2 atol=tol_erreur
		   @test gct_x_min23 ≈ sol_exacte_fct2 atol=tol_erreur
		end
		
	end
	println("\n")


	return 

end
