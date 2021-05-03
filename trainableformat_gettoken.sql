-- Table: public.trainableformat

-- DROP TABLE public.trainableformat;

CREATE TABLE public.trainableformat
(
    text text COLLATE pg_catalog."default",
    answer text COLLATE pg_catalog."default",
    page text COLLATE pg_catalog."default",
    category text COLLATE pg_catalog."default",
    subcategory text COLLATE pg_catalog."default",
    tournament text COLLATE pg_catalog."default",
    difficulty text COLLATE pg_catalog."default",
    year integer,
    proto_id text COLLATE pg_catalog."default",
    qdb_id text COLLATE pg_catalog."default",
    dataset text COLLATE pg_catalog."default",
    qanta_id text COLLATE pg_catalog."default",
    tokenizations text COLLATE pg_catalog."default",
    first_sentence text COLLATE pg_catalog."default",
    gameplay text COLLATE pg_catalog."default",
    fold text COLLATE pg_catalog."default"
)
-- FUNCTION: public.get_token(text, integer)

-- DROP FUNCTION public.get_token(text, integer);

CREATE OR REPLACE FUNCTION public.get_token(
	squestion text,
	iincrement integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare istartpos integer;
declare itemp integer;
declare itemp2 integer;
declare stoken text;
declare stemp text;
declare ilen integer;
declare ssubq text;
BEGIN
	istartpos=1;
	stemp='';
	ilen=length(squestion);
	
	
	while istartpos < ilen loop
		stemp=stemp || ',[' || cast(istartpos as text);
		if istartpos+iincrement < ilen then
			itemp=istartpos+iincrement;
			if substring(squestion,itemp,1)<>' ' then
				ssubq=substring(squestion,itemp);
				itemp2=position(' ' in ssubq);
				itemp=itemp+itemp2;
			end if;
		else
			itemp=ilen;
		end if;
		istartpos=itemp+1;
		stemp=stemp || ',' || cast(itemp as text) || ']';
	end loop;
	stemp=substring(stemp,2);
	RETURN stemp;
END;
$BODY$;

ALTER FUNCTION public.get_token(text, integer)
    OWNER TO postgres;

insert into trainableformat
(text,answer,page,category,subcategory,tournament,qdb_id,tokenizations,fold)
select 	text, answer,answer,c.name as category,sc.name as subcategory
		,tr.name as tournment,t.id,get_token(text, 150),'guesstrain'
from	tossups t
			left join categories c on t.category_id=c.id
			left join subcategories sc on t.subcategory_id=sc.id
			left join tournaments tr on t.tournament_id=tr.id