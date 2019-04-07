with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;

Package archivage is

	Procedure Passage_au_lendemain(EnCours: in out T_TF_Liste_Audit; Urgence, Routine: in out T_TF_File_Demande; LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise; dateDuJour: in out T_Date);
	Function retourne_date(date: T_date; nbj: integer) return T_Date;






end archivage;