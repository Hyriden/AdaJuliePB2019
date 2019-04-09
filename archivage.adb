with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit, ada.Sequential_io;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;

package body archivage is
	

	Procedure Passage_au_lendemain(EnCours: in out T_TF_Liste_Audit; Urgence, Routine: in out T_TF_File_Demande; LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise; dateDuJour: in out T_Date) is 
		Begin	
			dateDuJour:=retourne_date(dateDuJour, 1);
			put("Date : "); 
			put(dateDuJour.jour);put("/"); 
			put(dateDuJour.mois);put("/"); 
			put(dateDuJour.annee); new_line;
						
			KitPerime(LKtete, dateDuJour);
			Insertion_liste_audit_en_cours(Urgence, Routine, dateDuJour, EnCours, LEtete, LKtete, LEntete);
			Actualisation(EnCours, Routine, EnCours.tete, dateDuJour);			
	end Passage_au_lendemain;
	
-------------------------------------------------------------------------------------------- 
	
	Function retourne_date(date: T_date; nbj: integer) return T_Date is
		d: T_Date;
		j: integer;
		Begin
			d:=date;
			j:=date.jour+nbj;
						
			case d.mois is
				when 2 =>
					if (date.annee mod 4=0 and date.annee mod 100/=0) or date.annee mod 400=0 then
						if j>29 then
							d.mois:=d.mois+1;
							j:=j-29;
							d.jour:=1;
							return retourne_date(d, j-1);
						elsif j<1 then
							d.jour:=31;
							d.mois:=d.mois-1;
							return retourne_date(d, j);
						else
							d.jour:=j;
							return d;
						end if;
					else 
						if j>28 then
							d.mois:=d.mois+1;
							j:=j-28;
							d.jour:=1;
							return retourne_date(d, j-1);
						elsif j<1 then
							d.jour:=31;
							d.mois:=d.mois-1;
							return retourne_date(d, j);
						else
							d.jour:=j;
							return d;
						end if;
					end if;		
				when 4 | 6 | 9 | 11 =>
					if j>30 then
						d.mois:=d.mois+1;
						j:=j-30;
						d.jour:=1;
						return retourne_date(d, j-1);
					elsif j<1 then
						d.jour:=31;
						d.mois:=d.mois-1;
						return retourne_date(d, j);
					else
						d.jour:=j;
						return d;
					end if;
				when others => 
					if j>31 then
						if d.mois/=12 then
							d.mois:=d.mois+1;
						else 
							d.mois:=1;
							d.annee:=d.annee+1;
						end if;
						j:=j-31;
						d.jour:=1;
						return retourne_date(d, j-1);
					elsif j<1 then
						d.jour:=30;
						if d.mois/=1 then
							d.mois:=d.mois-1;
						else
							d.mois:=12;
							d.annee:=d.annee-1;
						end if;
						return retourne_date(d, j);	
					else
						d.jour:=j;
						return d;
					end if;
			end case;
	end retourne_date;
	
	
	--procedure Archivage_Audit_en_cours(histo: in T_Audit_Historique) is
	
--		use P_Fichier_archive;
--		File:P_Fichier_archive.file_type;
	--	begin
	--		begin
	--		open(File,append_file,"Archive.txt"); 
	--		exception
	--			when others=>create(File,name=>"Archive.sortie");
	--		end;
	--	if Audit.existe then
	--		Write(File,Audit);
	--	end if;
	--	close(File);
	--end Archivage_Audit_en_cours;
	
	
			
end archivage;





















