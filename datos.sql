PGDMP         ,                 x            basepro    12.1    12.1 /    J           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            K           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            L           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            M           1262    16393    basepro    DATABASE     �   CREATE DATABASE basepro WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Mexico.1252' LC_CTYPE = 'Spanish_Mexico.1252';
    DROP DATABASE basepro;
                postgres    false                        2615    16485 	   auditoria    SCHEMA        CREATE SCHEMA auditoria;
    DROP SCHEMA auditoria;
                postgres    false            �            1255    16498    fn_log_audit()    FUNCTION     j  CREATE FUNCTION public.fn_log_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'D', OLD, NULL, now(), USER);
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'U', OLD, NEW, now(), USER);
    RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
    INSERT INTO "auditoria".tb_auditoria ("tabla_aud", "operacion_aud", "valoranterior_aud", "valornuevo_aud", "fecha_aud", "usuario_aud")
           VALUES (TG_TABLE_NAME, 'I', NULL, NEW, now(), USER);
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$$;
 %   DROP FUNCTION public.fn_log_audit();
       public          postgres    false            �            1259    16488    tb_auditoria    TABLE       CREATE TABLE auditoria.tb_auditoria (
    id_aud integer NOT NULL,
    tabla_aud text,
    operacion_aud text,
    valoranterior_aud text,
    valornuevo_aud text,
    fecha_aud date,
    usuario_aud text,
    esquema_aud text,
    activar_aud boolean,
    trigger_aud boolean
);
 #   DROP TABLE auditoria.tb_auditoria;
    	   auditoria         heap    postgres    false    6            �            1259    16486    tb_auditoria_id_aud_seq    SEQUENCE     �   CREATE SEQUENCE auditoria.tb_auditoria_id_aud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE auditoria.tb_auditoria_id_aud_seq;
    	   auditoria          postgres    false    6    215            N           0    0    tb_auditoria_id_aud_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE auditoria.tb_auditoria_id_aud_seq OWNED BY auditoria.tb_auditoria.id_aud;
       	   auditoria          postgres    false    214            �            1259    16428    alquiler    TABLE     {   CREATE TABLE public.alquiler (
    des_wregion character(100),
    des_wgruenc character(100),
    totalalquiler bigint
);
    DROP TABLE public.alquiler;
       public         heap    postgres    false            �            1259    16431    edificacion    TABLE     U  CREATE TABLE public.edificacion (
    id_e integer,
    codprov integer,
    des_prov character(50),
    wregion integer,
    des_wregion character(100),
    etotalmuj integer,
    etotalhom integer,
    publicid integer,
    totalq integer,
    totremun integer,
    fonreser integer,
    wgruenc integer,
    des_wgruenc character(100)
);
    DROP TABLE public.edificacion;
       public         heap    postgres    false            �            1259    16434    edificaciones    TABLE     W  CREATE TABLE public.edificaciones (
    codprov integer,
    des_prov character(50),
    wregion integer,
    des_wregion character(100),
    etotalmuj integer,
    etotalhom integer,
    publicid integer,
    totalq integer,
    totremun integer,
    fonreser integer,
    wgruenc integer,
    des_wgruenc character(100),
    id_e integer
);
 !   DROP TABLE public.edificaciones;
       public         heap    postgres    false            �            1259    16437    fondo_reserva    TABLE     �   CREATE TABLE public.fondo_reserva (
    des_prov character(50),
    des_wregion character(100),
    total_fondo_reserva bigint
);
 !   DROP TABLE public.fondo_reserva;
       public         heap    postgres    false            �            1259    16440    mujeres    TABLE     s   CREATE TABLE public.mujeres (
    etotalmuj integer,
    des_prov character(50),
    des_wgruenc character(100)
);
    DROP TABLE public.mujeres;
       public         heap    postgres    false            �            1259    16443    perfil    TABLE     T   CREATE TABLE public.perfil (
    id_tipo integer,
    tipo_perfil character(100)
);
    DROP TABLE public.perfil;
       public         heap    postgres    false            �            1259    16446 
   publicidad    TABLE     S   CREATE TABLE public.publicidad (
    des_wgruenc character(100),
    sum bigint
);
    DROP TABLE public.publicidad;
       public         heap    postgres    false            �            1259    16449    total_hombres    TABLE     z   CREATE TABLE public.total_hombres (
    des_prov character(50),
    des_wgruenc character(100),
    totalhombre bigint
);
 !   DROP TABLE public.total_hombres;
       public         heap    postgres    false            �            1259    16452    total_mujeres    TABLE     y   CREATE TABLE public.total_mujeres (
    des_prov character(50),
    des_wgruenc character(100),
    totalmujer bigint
);
 !   DROP TABLE public.total_mujeres;
       public         heap    postgres    false            �            1259    16455    total_remuner    TABLE     �   CREATE TABLE public.total_remuner (
    des_prov character(50),
    des_wgruenc character(100),
    totalremuneracion bigint
);
 !   DROP TABLE public.total_remuner;
       public         heap    postgres    false            �            1259    16458    usuario    TABLE     �   CREATE TABLE public.usuario (
    id_usuario integer,
    nombre_usuario character(100),
    cedula_usuario character(100),
    correo_usuario character(100),
    clave_usuario character(100),
    id_tipo integer,
    estado integer
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �
           2604    16491    tb_auditoria id_aud    DEFAULT     �   ALTER TABLE ONLY auditoria.tb_auditoria ALTER COLUMN id_aud SET DEFAULT nextval('auditoria.tb_auditoria_id_aud_seq'::regclass);
 E   ALTER TABLE auditoria.tb_auditoria ALTER COLUMN id_aud DROP DEFAULT;
    	   auditoria          postgres    false    214    215    215            G          0    16488    tb_auditoria 
   TABLE DATA           �   COPY auditoria.tb_auditoria (id_aud, tabla_aud, operacion_aud, valoranterior_aud, valornuevo_aud, fecha_aud, usuario_aud, esquema_aud, activar_aud, trigger_aud) FROM stdin;
 	   auditoria          postgres    false    215   m:       ;          0    16428    alquiler 
   TABLE DATA           K   COPY public.alquiler (des_wregion, des_wgruenc, totalalquiler) FROM stdin;
    public          postgres    false    203   	;       <          0    16431    edificacion 
   TABLE DATA           �   COPY public.edificacion (id_e, codprov, des_prov, wregion, des_wregion, etotalmuj, etotalhom, publicid, totalq, totremun, fonreser, wgruenc, des_wgruenc) FROM stdin;
    public          postgres    false    204   �;       =          0    16434    edificaciones 
   TABLE DATA           �   COPY public.edificaciones (codprov, des_prov, wregion, des_wregion, etotalmuj, etotalhom, publicid, totalq, totremun, fonreser, wgruenc, des_wgruenc, id_e) FROM stdin;
    public          postgres    false    205   у       >          0    16437    fondo_reserva 
   TABLE DATA           S   COPY public.fondo_reserva (des_prov, des_wregion, total_fondo_reserva) FROM stdin;
    public          postgres    false    206   �       ?          0    16440    mujeres 
   TABLE DATA           C   COPY public.mujeres (etotalmuj, des_prov, des_wgruenc) FROM stdin;
    public          postgres    false    207   ��       @          0    16443    perfil 
   TABLE DATA           6   COPY public.perfil (id_tipo, tipo_perfil) FROM stdin;
    public          postgres    false    208   d�       A          0    16446 
   publicidad 
   TABLE DATA           6   COPY public.publicidad (des_wgruenc, sum) FROM stdin;
    public          postgres    false    209   ��       B          0    16449    total_hombres 
   TABLE DATA           K   COPY public.total_hombres (des_prov, des_wgruenc, totalhombre) FROM stdin;
    public          postgres    false    210   �       C          0    16452    total_mujeres 
   TABLE DATA           J   COPY public.total_mujeres (des_prov, des_wgruenc, totalmujer) FROM stdin;
    public          postgres    false    211   ۓ       D          0    16455    total_remuner 
   TABLE DATA           Q   COPY public.total_remuner (des_prov, des_wgruenc, totalremuneracion) FROM stdin;
    public          postgres    false    212   ��       E          0    16458    usuario 
   TABLE DATA           }   COPY public.usuario (id_usuario, nombre_usuario, cedula_usuario, correo_usuario, clave_usuario, id_tipo, estado) FROM stdin;
    public          postgres    false    213   ��       O           0    0    tb_auditoria_id_aud_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('auditoria.tb_auditoria_id_aud_seq', 11, true);
       	   auditoria          postgres    false    214            �
           2606    16496    tb_auditoria pk_tb_auditoria 
   CONSTRAINT     a   ALTER TABLE ONLY auditoria.tb_auditoria
    ADD CONSTRAINT pk_tb_auditoria PRIMARY KEY (id_aud);
 I   ALTER TABLE ONLY auditoria.tb_auditoria DROP CONSTRAINT pk_tb_auditoria;
    	   auditoria            postgres    false    215            �
           1259    16497    tb_auditoria_pk    INDEX     T   CREATE UNIQUE INDEX tb_auditoria_pk ON auditoria.tb_auditoria USING btree (id_aud);
 &   DROP INDEX auditoria.tb_auditoria_pk;
    	   auditoria            postgres    false    215            �
           2620    16499    alquiler tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.alquiler FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 5   DROP TRIGGER tb_persona_tg_audit ON public.alquiler;
       public          postgres    false    203    216            �
           2620    16500    edificacion tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.edificacion FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 8   DROP TRIGGER tb_persona_tg_audit ON public.edificacion;
       public          postgres    false    216    204            �
           2620    16501 !   edificaciones tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.edificaciones FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 :   DROP TRIGGER tb_persona_tg_audit ON public.edificaciones;
       public          postgres    false    216    205            �
           2620    16502 !   fondo_reserva tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.fondo_reserva FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 :   DROP TRIGGER tb_persona_tg_audit ON public.fondo_reserva;
       public          postgres    false    216    206            �
           2620    16503    mujeres tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.mujeres FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 4   DROP TRIGGER tb_persona_tg_audit ON public.mujeres;
       public          postgres    false    207    216            �
           2620    16504    perfil tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.perfil FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 3   DROP TRIGGER tb_persona_tg_audit ON public.perfil;
       public          postgres    false    208    216            �
           2620    16505    publicidad tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.publicidad FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 7   DROP TRIGGER tb_persona_tg_audit ON public.publicidad;
       public          postgres    false    216    209            �
           2620    16506 !   total_hombres tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.total_hombres FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 :   DROP TRIGGER tb_persona_tg_audit ON public.total_hombres;
       public          postgres    false    210    216            �
           2620    16507 !   total_mujeres tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.total_mujeres FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 :   DROP TRIGGER tb_persona_tg_audit ON public.total_mujeres;
       public          postgres    false    211    216            �
           2620    16508 !   total_remuner tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.total_remuner FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 :   DROP TRIGGER tb_persona_tg_audit ON public.total_remuner;
       public          postgres    false    212    216            �
           2620    16509    usuario tb_persona_tg_audit    TRIGGER     �   CREATE TRIGGER tb_persona_tg_audit AFTER INSERT OR DELETE OR UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.fn_log_audit();
 4   DROP TRIGGER tb_persona_tg_audit ON public.usuario;
       public          postgres    false    213    216            G   �   x���K
1�uz�:�.�	�N�b�m�t��E�B7Q�"��$�\z4J(0^�jis"�����'.�B� r	<	V����r�������DJ�9����;�ʫKӍ�����?>��ns+z��B��	��ƍ1�̂e      ;   �   x���K
!@�����3f)"�0U�N���?G����d���<��T��W�(9/��RZ\b�wI�6���m[�B ���O(�/�����])�.��R>4%���ި�H4�H<B4X�zW�Q�tK!�����C��E�d���S<�(M��'#����3`A<�B�t}�a      <      x�սݮ�ǭ$|��*|����eGp4�O G3���u|,��{f�$`�ñ�J �wqu��d�����ۗ�_?��=�|���ǯ_~����z��?�S_����ϩ�E���C�NZ������o����������a}�x�R��O���w:�G�����47��D}p&�9(y��������S_e*N�C�&T��S�H�F�c7�NEIWG�+YW�N�'$9�aq���Y*�T���u���}��������+X|���g��O���Wj�JKv�����X�=�:M��g*P^����/�W�������@e�(�)��'������E亗Cq�����������o���ow*N�٤��,�ĭ�_�9�Q�s;L���ƞ�\���ȓ�#��艣u�"3�Tfw��	�]&�cTq�a���)�
��Q'k*J��7��0ԭ|��2����J���hu����7*X�H��|.@�:@�.ω:5׭����)tP��i�ǂ%�߻*�
?R��W��
�Q�'+�υ�2���g���sc� ��GaQ���S�����A.��>O\ٓ��֕��p�O���vr.G��0�K\���4��š2���>�S�����߾��g��#E���۟_�|����K��B4���u,
<�����>������ۇzQ�������[A\����>��p�闹�/W�]U�u�
[v���������ո��J�HE���V_�ϟ�ަ"�Ovd��Q�+�c���i�nPG��@Gi,2���P�V����g�6��<�Ƞ9�x��׿�\tt����EF����X`l��A`�	��'m�:9*��_�}��`������?��'��q+���Td
_����?���#�%D��)]���)d3��q��N��/����??��Ǟ��w�i� �:?��b�
�2�Ӓ��7�V7����Z��V�>�R�J<�����U�T�h{�q��EQ9����{R�ĻOU������&z;�=#�"���Q��c�aD��
� ���ǫ�Hä�p�'b��x���2�m�R����	}�Ö� �nJ�#5"��~�>wxb�������>�����|�������>���#4�|���5��d��d1�Y���0�3�J1��;5zV����͹.����i@x����h�X/Yw�4���"$�jRx*6Ri�ç_�~��Jk���J�N�\PY��X�����84��2�jv#b��=@Cݙ�ZA���p����Se�zA)�בӵy����������E�"����˦���X�����O_�8�~��2������{]5���f�+A	͂c���Pll7��*��KE7���9���8�xy�v� u)e.��nhL 9]5�Z��c	�v���`��H3� rG^��L���-��w*"�`s���5b�H�g.	-��)�,�M�K�u���G��N��ԌhT�u�
A��X�n������!���p7��X�R#����U��c�����Z��[9넑�����F���Rӈ�7���a�sU	]��8�67W%1Mf��_�^���/���'߽.XH�nZU��C�>'?Q�r��݈���*2�����n*>�a7L*{K=hZq���*۪�}���X�wC�w�Q�'%��˥�����P����
���|� ��2oL�Wm���a/JPk�w�:O/z�����0���*q�������$Cb���\zJ�(~���Ϸ�������?�z��_����ˀ�k��_�LT[j'�u��\���8�_�u]��S���;2��k [/�L�h&�G�����⢪=�����c� �έ��?���7?��2I��m�sL�خ�q@r��J�R���5� K��~�������?~��=�A��:�7Ÿ�Կ�����CG�\�3��u��I/ ,C����.�	�G�ƅ�"��3��(���-!��o�.�#�\G_[�l(H��$X,=��4k펑��w�;6�<��j�`�?��g��OքF�������v~_J �dJRc/{�����P�i�p4���h��r��4��rV��[��C�bڱ���R��ܴ�j3�1�a��77����;8�Ѳ�z%��L�9Ys�Y. �ϋ"�P������������"�S�x(0I��?��<���X_�>�]K�&�>V5ܺ�OE��_�����,��W�]���H#���THau�P�76}oʢ4
�r\�51���&��"<�D��ء���U?����Bs�GW���.���a%���D���~��H��8]tJT��c�R���������78XY����OU�cX������__����εr䱮9�Ē�ܱY�;�d���!��|N��.�Ȍ�x�����B�]8�,���1jM�ŉ���z՟�0�ҹIq�Al6q�g�vV��
�"��hY�F|�ڴ��M�sӫ�H����$���,-3ܮ��� �rC�:K��j�A�z]��s*�t�����	=
H�zrR��/�xno�)���2p�1�⋩��T���(ª���Ɛ� F����Y.�~1��
�T�9r3��`��iGg��^+@�A�6`6'4J��{�ȟ��E/A���X��<s����3`GlUЋ�S�ZXR�����-G�pލGY��"���	Q�*�eP��м����|��Y�R�X��ɐh9u�rR&�#�ݢ#f����#p��C�i8˵��9��bn�A�!S�!޹'���sŀ[��OQ�~�	�|��nꭗ�&8(y�VU��w��^���:$/8��J6�Ix�?��{�i��G�m�7��,��Ńi	hv�IB���(�K�2��Ե37("^�a�	F+�h%�"%���K�q��??�Y�K�k;�^xRM�xyw���¯������zt�o��q75��@�8S�xEb�3-��qZ�q�O���Cc;� 3U�n2����m<�r��zP�&��Ҋ(}�� -�U��:�	��{��U�9�9�C��������i
�li���oo~3��R�UiS��C��`�l٣ˊ��������hB���n���.�'g��!�-��P�[���:������o�r��l=%z��� �r�� 00�&�0v��2$sj���a5J�x��<��5�v&e����vA�d�����֟dJ ���R${.0�ݪ��D~A/���k�$�-V-~z@�u��	%sO���mDo	� ��@�s�
�ݺ��}izX�}��\�Cy�[��ٺ-��-k���� ��Y�;�/%!��b%�9���Ŗ�ZoXUQq����͹O�r�D~�b�����`��A3�(��LGc�L�t7n���,��Be�cN������w��ҍ�9IZn�����l�9M`X-��s�w��z���΃yۍ��/�Ѥ�=M����7W���ŝ3f�V�X��ס!�Jk,.�;.P�y��I����9�!��2�[?G�����'�v#cm�fG��A4�d�������{�A����\��H��=FP$Lͻ���Ưw��
��n'7g����pG"��M�
I��]�Ѽ�@�"�'4H�^�r��v�e!�i�0,6�ɹ��谰O�tW8�D�y���e4I�]��s�F�׫b����ֆ=}?A� �:��w�gz�s^@QZ%��<xz�#h�T��/��<����d#�w��Y�R1v�)�%�x҃�:�]��x�>�/�(��UV/�^���,vcj0�D��FxW*;H��� 6��b{����vG
U?&��y�S��8A��k�+�`Y����Eۍ�+Q���D��������8����u؆W�>�hߋ�)b���!6�[���Nׯ�W.��؍������N�5�������uX��~�^���n���؍��U�iYh3z@��Bu�@�y,R�A6����Gh�V�T5�<U��܍�)�:Nz=p����W�K�la�n�� ���T![�ZX��S\z�xE�X1�y��/8�����b��)T ˹ -G��#=P�
��	&��\��<wCo��    �C���NSe��x.sc����v��^��U�#x�㶬N=�gF�n �������ܐg�}E��Ft.��T��V�n��������ϐ$�#=�rl�q$W6�J�ɷ�NU(F)F��:�m!��*YP��!�� �d�y5��].����{2R�#V�*oV��-<��|��<�@w'O�õ^�)��s���f��
����R��G�����2B���� ��B��N��]���z�+$��c<?.���wiH���9�����gP��.W�.�	#B}�t��0�i�>H������ﴭ�+<
�F�3c����Ӈ�c�X�<w�f@�=�i9"�w_T�UWZ�+���JI��S���:i�=h���)�9����J��`}����N�ǀ$ows��᫲�Z��i�t�A}b�n�H��d���5�*n��|�nCŸ:L�6	m'h�>,U�"DɃ!Z�����(,�6y��Q�pIc���r|��� v�6�Uy��S�\������"�<��-���z�=.��Fp����V�+@�T�Qo��µ˃Õ��wЅ$?����+��������s�dI˄L�\��O�^����?J��M�2�}�������e[��iwnb�Mf�{~���(��~P�Ŝ�l*m>>煁�ƀC�bs��L�mb�PK�8��������D����r:��Y|�r�!j�x$S�^*1�#����N+^R�|GГ/`�`�}+BҎ�q�.!<g2�L�o��ŀٓ�m�5�w��0ʻ���b�4c��BcWZ���/�����L�f.4/��#XA��@��V����|h�#S� �x���d��0�V_m04�[��P�NV�	AG~����H/�\p+z4��2}�����6�/�L^��0r��-3�a�OEG�A���o�~���q���P$�����.:�+�s��s��up+2������V.�k[�0za�r^3���S����]�t�C���Eg9PFRF���y���*�m�~��{����&H�q���$�;�%�� ���>8��bAI�8�)��v����:1��xD��\���fY�����y�=�G�O�r��j�@���מ��'���e̖�EW��~���E��;w����_߿�^_�����;A�IU�n�)�� /q���.�7c���nWܱIG>zƖUX�#jPm^��U;r�Hu�"G����!����k��}�����LXV��~?VW�/��9G�B�S6Ze�kU,�s�W1�e�Srb]���N�V�
��ۗ3�̫s�i���$T��y���r�Ջ�Of����q;-�PuN��M�bm9�f�8Αd��~�P��G-����4��{~��8-��b�vӡ�yI�ޣ�9{`���Z����+��{ŀ�$��!��q]��ǋ���_����#S�ݹ��\�h<��ƏU�<�dZ�����9����m��\
�!ns����9L��x��i�h���G�k��b��f�dox�eN$�m;�F�Q���v�rku�(ذ��?�+tj�e�e�L{2�~��;<0w�-y�mRYjp$����t!.V�VR
�Ⱥyv���k끍�˳�х�@��A��/G��^�����4������ह��"��U�ϙ�/��l�~��8��P�Ŭ2��":�����5�W��as�����b͗#l�9����"�)*�@�{.L�1v���I�[wkL��'�kʔS���l���
�Id=Ŧ�����Ay�XNq�nZ�LUj��n,�
A܇�����}&�A�]q,G�u���#fiu˪�zq�����r���	y�-P �i	nDd	�t2T�8u�I�.4��޹.��p���9�i�(�'�6��C��L���=�-U�#�ɣM��8�
`bK��%R��CFPLQ��In,G� N�+���U����}p��A��fn];y��¸��0����W ,�s�eBH���XO�����!�\��a�Ľ���y	���7$�]�՝3�sHMu~R�{U.5�1s9!OћU0�����1�f��rrr;"?(��wK)���"i�X�(Xns� ���6�PM@�½�S7/B���g�h-�������Sv����xߔ�r���Q�<����#����T���T����<��BN�:c� �G�b�^��Ύ�p�+y<~��;���`���sfX�Up,�ɳ��Qu�� #��^7����bH��W��>�6�(���
��
<Jnwzbɕ�ĸRz;�H�A���펍�Oڥ�G ѫ�b��s��ʐ�|���oo�����Sf��n�^/�VP}�?>|����}��_��㯿�װ�&��{��v�V]?u������b�P;s�fؚ���caZ�� z�����i9
��u�`]�s�q��ǒ�l�v��o�V]3L�@
Ϲ-���<U�η2*^7碳[#�\�\����c(t�K�+7��x��R�`=<��|�sw.L�[u��m���KxҪ�@ON!@;��p��J$������Ҕ"�F��ڱ�o���J�IP��v>�˃/�r��}B�k�gՄ:Ccq,B��T�뾔_,�q"������vWGH\A(|�2�u����C�pHwMk��#B������>�ܡ��2���[>rKv�m�TE�5�t�k���飵��[c��I��=¼F`Y��i�eh]��*a,D���ڲ�� d���TB����-�W2"�Z�T`�iN%��X�Mh9ঞx�E�y�z�0�
�K�����\��7�|���뗷_P�~|��Z�r�{��>��������-{�<���i�s}�pDJ��w��8/��Ѽ��ғs� 4��r���O}�� �x���v��b���睊F�����$T��B��x\ȟ�\b���~�,�3p,B�������+V)�j�2���NE�$�ճFW�(�^���`�zq�@�%��@��Vux^ld&AY��2<+�� ޖ:W�0���NO	��Ǳ->W��^,o�u�sݺ���t�y,P�I%t�����r����&˽�	TzCl*V����f��#=���&䪕�Al���*��� _;L�3!`��6㶛O���9>g��v�y{"SA��AI�.CB��@<���xV: �=��v�XlP-������x��p.4��xTƮ2����`���Ż͎<AJ>-S�������V���뿾������?8��_F�t�
K�+�dy{�Pv!���/���*p!��.��r�}���ӧ�/?�v5k�eL.����#a�;׬�P��?�����?����l
��C5��}x����XL��|������s1�M��Z��N�:1n>Ww��\��i�K�ݏ5�p�`thut^��'W%�����륻;�=)f$b2gA�G{28`��k�F�5���9-�CъxN���8����p�����d�*nS��}jhܼR�;(#���Đ��N��A��D16�
�4��^�*��Ǧ���X�b�QJ��q��`Q�@�(8��|�� Bw�D"�P�̉.��s���gCHQ�<�
������k���vr��o�Q7��@wt�%�IL�� ���j7�%�Tm�ׅBN�o���0P=<�"�ݐ��|��ݪT�����5H�1	��������i
.n�r��{�b3���c�A[�P��Q���_�U1��
���^<�
p�<�&i��>X�mw��װֱ��m%�~�S�YN �_��W�{��AN]�iK�,��9���E� ��L}wk�Zϓ��=��l)�#s��/ߕ�����\780�+�%�X���Jb�$Q�%<ePOb�S���cv�j_�A��z{�Yb�T�W��A]�����u�Q"P�	��;�A�nX�XŅ�Z��t��'��r��hX�
����T�Μ�lw���:A�ްQ?PW����8:��m����>2�!a���������	��9��J�SB@�P6$S�[�|�Ρ�������Ok[ ؀h-;",kO�lUr�;I�ZC�!oX����    *ޙ,��{T^�Ӹ�������F�������~&(���X�]��g0X˱ww��A��@�W��7��V ce�߻^�?VQ"�)G^���<p�8�޹��톕f�}���HS!�vY��'��0^±pm���R����̢r;�,�xO�3�;�ݽ��CO-����	`�vS��mI�/3�c�w���^�]�P�������N�$�VR���S���=��]�L�k9d7���&����s�.	��do��ksU�zGKHAx�U�)C5�*t�լ^�����k�s*h��)��i����S��żS!�;��:'��T���B9����
��nʸ�B�;��i_�;��@�v����2'�+�qz����*��6�Ҏ��-h�!K��0Af,H�!��[���}�t�ջݷ�ː�)�N����p����v���ǹ�ݢ���������U�T��T���F��s�?%�B�����e,6ۻ��{�����ow�lAs�35�����r6
����Ur���{ ϝ��vs�rLJ%��� �O�_�9��v�Iz�A!������z��V�Q��6�i�2��g����s��0pr�b^!nXeº�X�t��$;���Bl(2$5L�7���۽'����̄�T��OڙK��n^!�� `�����9��[Ђ��cG��3S���sml��r�_*����h��\|��-6����(���߈q��P��T�AEn�nAY�H�I8��ԛ�~�'d�ps.�݅#�V���4�6Ԅk�X��c�Ɂ ������	�u���`[�:J���di��p՜�nw�T�K<�R��~
 G"�0�uIt��$�W�R`�`��u�
x����Z�
�r��-TU���SK�^׍��\n��I	m	�Jΰ��񄠓�-�*�`�Z�+"�8�z�V���ܐ�-+�8�v3H��hmsk��Qx��)��7�֝t�9%FJp8W�S�X��C��uw���p(�E@yVBf
sS�1lS:z�~,V��8t���}���R5M��9I*����6���^q;���2�v�ݲ���W4
�[�zxjnf�����ЗT�c�rs�װ�@�K�����(�n���$l�������0�������"2'���='�/v�rwI���9)8ئU����n�n����B�Wn�n�	�}I���n�n�Ja��H4����5<,���i�l��L	�l�*Of"���-�V/�P��w�d�s+C�es�䯧�V�en�He7X��٣��vRU.T�ܠ�Yyzn�Qe��c�
�J�E.�w��M:��-ٽ�A	�`M�x��`F�Ӝg��nX���HI���M��s;�*�q6�vʩZ~�������R���Nfy+=�ޏ�'�Е�BE�jE�%5��ho�I�Ur�#Q$,&j�SQ��,��>B��l��[Y�H���l�v�6@�gns����9���!�n�-Ԁ�4�,n
��w����pGMbs{�-ͱ9:�7ڰ��x��8P���ò����A!P��)=
>�}���_�����/������52(jޤ��4U�J\{T�Që�	��B�b]Q��L(�Q(��{��:XM�r���5m>Ө2�����r�H�I�pC�z?�T5D���9=Z]�y��1��Uȣ]o�\5��R{��|�M0�M7�lw��f<��Ayq�+W��Nǜ8�n7}��Q�N����3����]��# $�F�9�����TOY8���`	�X>hˁ��t�4�f>0:���4�| ��!����Zc<'�ts�!�s�4�9�9]>Z��+϶�>�}
%��7�ܴc�Ms�;����<]O�^9|��Px�˸w*J�q�4�ƖTb���U��LJ��vO�XK�+���\��?��es�^�F��S���D���nr��Ok�l

D����ֆ�zX�k N��bQe��$��@�/�gG=+r.?΃�)�M��n�A��^2��(�n�u��֢_=@�w�^��n5:��؝I��CZ��^cw��/3��/��c��j�ϸS/7��Cij��gp�0v�g�0,0�e����0��p���T�ѷg�ˋ�-��)P]�,�����ҳ�q+��l��3����4<R���{��P�=��5��l.L�5�Ǟ�>��Q2EJ�s1�������kg�{�"A�vUU��j��T�ِ����hMK�J�Ӳh�b�mce��Q�Ӽ?&�u�b0J�����&%�����i˪���d���cލG �Ӝ�:Ss]��f����/.~���2#M�Eh7��<��y�R:���N��x����|S�m
^�	W.��\���aw��x������`�T�U&�r�`�,AڂR�a=꺠D̕&�v$a����$��v�B�T��[26$�~���NREGd��T�;3�}��@��juH܎Eg9Qğ�@�����ut�z�4�����X�=��iF�`y�`�}b�J�ݬR��7e�Gƺ���>���l�l�d�0b;��M4�����aŬ�*D�6��HL��3��;Y$�H@��ř�n��3�:2�e�ڞa�
����l9#f$Z�v���(_���v�FB;��䈪?
"A<�x� ն�5�v>{�Ec�,a	���qN�Ҷ�6
�$�֮͝�1m������gۭ�~ m�s�����q��l�i#r7�]�G���24�DbN�ж[7Vj��^J�tr���o��cQZ�.U�V4�*�Z%(%�j0ɹ4������[���
���%X�����7p��w�à(�B��{n�Š�6�퐼?_��r�=�!/� 2�n� l�8�?)�(.v��eng��i��;�~:Pc�o!�Ց��bS�G?��ґƛ�s5����u�c����G��ޫ��$�e��L��������y_�0ʺp~�0�vOF�h�QHQ&��
;�9ڭm�d��Jx�DD�gq��;y��#k���*b��׃[-T�6��oGՍg� ���Y���#��\���A5R4V��a$p�X*4��b�s�	(?_�}�����O|������o~���K�����aV^r�5��l?m�iU�<N  E��v_"��h�H392���8	ձAk�����>�,�8�#s\$[��(��d��t/�W"�01��m4f�ȯc���W�����s�E��av��؎B3�T�q�N��rt0#m�X�E%+r:�8*��s}Y^��ϻ}��9����vl�F����d�_w��㎚,��T�
�fRDx� �[�h�����ꐰp|���Ⱦ�B:��k���!�~)T����̽a��eM��Pjm�$92c�q�2��o޵�l������
�����O�hg�92����6�1��}Z���R�+ .:.Ibe|�+�+�W�֜S��펎u��.U���x�%��A.I�`{Dv�G����'֫�X�9�]��R$P��d���4�Ժ�9c��f�Tt�.ZA+��������"����qp}��������l%�Gz�A70_;s��GZ�[p�����,'�!��wM-�h�i���p"��`��ݿ�b-��+@�l�����A�_z�~Ѓ͗Xv�f�A�i�y~���Ϸ��kUvx���/|���������fVyOhܜ8e��stw�(@qnu�`����V�?$�6	�,,J�4�
$U��h$Ⴥ�-o`�740�i�Qa����[��X��c폕���s�-�];LVz�J/�PX1c�Ʌ+[޽~�^	��	w�;��v����/������?�MN:�a�Z�D��>X�����t�8M�R�Kg�/x;b]?Y(���bu���{p�k@�� ��v����C���y�jw�Gk,<�����Ē��r�`q��#�0r�l��:U*�lwo�-��nY��c�rpؗcfi̜�2�C�_�T������4-h$2 ���_cο�#�QT�v�6�(/ö#��"�/τ�)�9	螣p�M��'4_��̎���Ӻ���cAZ��+IS��6�F�^�=v>9`��\j��E�    (9D���덛;I��'����r��	^u^+(�ւ�2�^`�g;.�5y����A���d�(��mB˃���80Q����`�(�nje~qh�)�E�:0	:g25-oT_\��P�R7e}PH�b9�I:T�� 7�����O�2�F���A���n��@_^�ŏV^lk�ʹ*w��#t��"�,m8��.L%�?c����.����~1̧����б��V�Y/z&�y���ZB�[D�B��=������`%�ip$���1�6腆�&}�>�d���K[.oeoӃE�P<>�9ւ��Ց�R=fi�|�徎h��</yB挝m��#�"�ƃ#/j|5�P��CB�����闯�~l������܂��e�.�;g�:��v���B�������T:/�B'����>u���A��QQ@7���$���[�=�:�r�(L�m^u~�fμ����rvh���9_�u&c��W�mw7��W�mfچ����KL���� ��ز�����$���Q�U�.J�˭�w_+EN΅i7⮧{z�}A6WM��l��JFw;��^?���<Z]>R��9l����Pz�F�B=*k+CR��0m]��<N7�_�uI'i�h9�n	�zڜ`^�`̇�Ib�f,L��ڰ�^T���f/�O��X�P#���F(E����P���uh�	lrn1·;>2j�kE{�[�I�-���|3�Ա|��#��:�˕/9�F��O^���v�G2hқ2�#�p�169q�>����_�~��3����|c>t�QH����i���8mg�@�;��b��������бv��<i��(�o����T�I=s\x�n����:���\=v���E����ؓ��&�TR�L�������Q1~�=0�m_�h�u"�9v�n��g(jA���ZY�z�2B�:Z���a-��~�`���?h��(-⊙&T�{`/�G��������<���]¦��>������h9=�rD
�fkw���۽��z� D���sRH7�����ׯ��������;r2�C0Ȭ��b��'�r�}�����A�C���>B����	�R2R�(�9��v�G8����n�0����=��Y�{^���z��I0G^}p`x}�f.���4x|x�A?X��7�����'���쎐wa�؏���z���D�ˑt��/��8���71�n�C���ASk��0�[Fv^.K"򠩈5 �����.4���X&!�=V���6��RKT�'�Z��Vm�Ə������>0��r\�i�iO����#��r�F9[D�^�D��Br�QB��A���k5�|d#I{�7�ձwV%m�I��r�G�I8��!��kn�Q��߹�m��#�:R��1����c��J[�9�{��m !)�u� t� 0U�yB�8�Q6�l��}�B6[$n�1!�;>qA�*�P��+&��+f��̓���-���32����iաz#VT�w@������ou,���a����B z�[�K+W�tۑx۪��U�Z�0
`&����9���	$�w�U b�-���X��sE�.G��hۋ�Sp#T�x12HR��,�'Q�9VP-�[6=LO˼̽{��Wɫ0C�HE
`�;�~�j`���y�.��0�Z������Y�q!d1b��]tyW� ۓmt#��1�Uߋ%g�b�(����:�Ba����S��D'A�\�X�,Y��	��b�S�t]�iYh�;]Ηv��%��S�tip5N�/[&����ޝ�WG!s<��ƃkq�����*�"�T��1w���JB?ǀ������Υ�����L�÷��¢o7�l,�4�
V���;���8XW賃S^�2A���ܳl{[tA0X�h&v�&��`�|�)�7�_�J?��C�'�r*7�)��`�3=��xo�=&�5��C*\_���*ٴ��` g��J[��V �:�������T��K�Δ/g��������I��v}�~ �p|�0���}P�w��aVX�?!�f4xxv��V������&s}"�-��_ze�3�̹^����W�a��@�%I�h�(�m��c^8n��n����z8���Q��6�8sM��� �������q�js]���X���-��m�A�V,�J�� ��V
��]�3�?��P�?�m�й�K>�����������^w�F�v��[��M�h��<�b4�~���B����f	b�G{K�\�X�����0R�Fo��b�a%ґ����r�L5QqDk$������,��il�!a$�Q�C�ِ��(��ԉլ^F&Y�II���\�X�@�z�����Ͽ��ת����ϕ�|���*�&lmu�[9��6lp��5RAV��t|����=�l�垑 ���j�bE7X�NԠrf�rgDj_"��m����	��R��.5�&	�f[� �`=��@T��%�gf`EcPa��$F��OY�����Xl|w��p�B�L�G˭#[�ek�*�3��_ny�K��6���}�&O X�x0�����`�����W����$f��Z�
ɽ��u�"��9/1_�iuv��MR�zU��@B����0оG�#�a�fD�{�� ���@�[@�&�/�� ;h��cJ�8Gɬ={�M�����t�$tD�L����c��~�ϻ�ǹ���$�ͥ��x݉�=N�z����*+D����������T��ݨ,t��0/`}��ȣgr�����H�z������R����fV�<A-�!n!PS�ws�����0�k=j:�����Z�o�|���ˏ~�c᩷���k��j}�<Vw���������Tr#咽�`�����F��6}�r-(\�؝sJ��RC�� �mD�b��}��ݗ�`T�)Ԙ�ڌb��m���OC��>U�A���	��!r��A��Y#�~*���Ǝ"���4�hw�&W	�l����fg���9���k��$���A��B=����	e�X�xus��R`��;�\UɅ���F����V��n�`�3!V�n�W��n^稪��"iݴ',�Vڒ+�7�r�����Y�VV�.dC�޹��v�p�eɲb�VO�`-��NЕ��Z�\=ȥ9�B�D�PJS��)
�����0/�*
uV� �V�i0����wҬ�p�I=̧py���/8z��qt?E�xI��ow�B�}�O�Ů>���d�� 2g&�\f[�4��v9
cxd8����Ǧ�z�*�*ah*<>��:����oJΧ ��!�_��`zZ���A����A�fΦ.��BP��뿂�*��1��I^����K�Xh�eA��]�ۡ!���q�#�\��w�v�5��A�IH���#ˁu=�����F�z��csk!0xݬJ���a�=�''g%�J��	���{9������>AU�?
�=�d0�s���$s���KVת�o\ll�9���WLq���s�EC�����U�{;R���c�5x�,d�b�Cc;�!fT�:ۭ��$�b�����LrW����wNc7��Y,�}�־?�ddr�C���?87n>E��V���]lul�l�x1��$+�M�BقY�X���jt��p�<_����.�tp�XC��I}�wVdB� �4�n�x��H�������I6�и�aK�9{;���)�vCƗ�}��gPHȧWb*(Ƀd]�aS�Iۡݾ��r�Yu�ŝn���ʵc����a���/������2��$A�k��@�D��(m�_����q9'F��������%�{,���)���q�]sz�#RZ!�$��fs�"�ݶf�[T��8���ÖC�WY&�������0������uU��*i`]�H��3}�[*����|���X��9r��\�h�#r�˅ܳ�KUNZ%��g9�ƺ
9c���ͯQȹ.�v#F�fW�E���8(،��V��s�<��@��I�.�V'�f�;l:��.6�0~���u���xD{x�@Cm5y�m��d+�|�� �  �w������lx5Q!xh� oؗ#���¢,t�����
Dhɫ��+j}9�nu�wO��u���D���:<D(��|�!�4bL�q��X˱�!�R6����)� )k�e#�CQ�.]�#̓��/�4�Y�ݷ�-޹[���i�ND��c9I���H��^B��@k�.�,gKUs��v;G0#�l���%�!�9��_�WcqZ�"�~�k���ڼ��@��uck�>q���%�$�<J�{b2bc訒�*���z��"��JR��V�Ҋh2Uf�A����nَ�d"�I�W��(y��c,L��� �VS���M�̹:7�X|��#l�(k![�N�9�}�|�7#>{�E��`G��l�y>~�����?���+g�j:#�K���$��m�"1NЁH���N>�V�c��H�n��<z���m�#?48���o��TEN{gh]8�ڙGųry�����ҁ�eBS'i�c];��w.�{;C9����U7H��i7����I���@,���_Gi����>IP���������o*m��r;���o4!٪�T���iU.�ފԃ!Sb���:Sh��:]4������J�H���� k�W�?v�S�v-�:
88Q�I�U�Q�������;�]���$6�.��������bmR.TA��B7a4��8��,�Aׯsx(v��������t��̄���3ǅ�.8��)w9�>�����B�.�w#� �����y�d�^��}�4i/R�Ě��ٸ�aw�h�����%�47�7q�;b���Ty���\y�7��=8��Go��f;�nb­7^���Se����n��o\Ï�+
��M����QZ��v��"���^)�
�K>�f������>����/�'�C����ϯ_>��o���-	��D������,�����P��H��1.i.���x��.�+��s��mMS��O]o�C�8�O��s�۹�+��ߐx9�9���}а>�;E�#�����l(�L�%� Μ�xb@��Qj6��H�hL7�/4$�꒶my�N�~Lo2�����elb�H�����v�0�%P$��H�gN5!i���>U�uk�rh&ds�Ѥ�m��֮du�ZoF�*H�ԭ��nj$����ZR|�9��Zް��]�*Ā*�\G��7������x��A���#-oT��� �L8}0s�ݮ힏��S�����Q��4犙�-!��Z�N���D9(����W� �HF�GK�(rh�\�����!}Ԇ�������`O>���W����u�rt��`��Z?��ں�fW�SQel�=�fu��廛"����XnKC�9t����I57�V$��@<:������.�JsB�ɻ�ַ�x����+8����ܽ��닦F(:�ҎWYo1ن����.(��`{��m�����[ ���{2B�J�g�������x��p��bE9o,��k9���Q{<����D*/Z��,�W�?֋CK0h���l�nH�q�}}��s�T���D���|z����_�`Z��7��@0ud$/�svN�u��>(��R������8ݬ�pE��>�����e+:�(�XF����Snw��3��< ��$A�u�;�
����CO�Ēu"���X�1gf��}���ϣ����یz�����<b��kh��o�9c�T��et�<��J�OMu��=����y�r��~D�lH�b/�����\�v#m�&� 2��� � e��zvu7ܶ*?��wB�HJ���,�4��փmp{�pAو>������{�r�vCH�WO�F~�T��;J l��EE�Z��gP�>m9�Z�~�ʏv�ڜ}�rxͽ�LG.�3�ĹV))Xۍ �R�g����6����@�I!JP��K��̪�G���.>�S��� X��E�N�����CU�lj8�:��m!!�GÀY�=��a�Y*��c4������o��6��Q      =      x������ � �      >   �  x�͖Kn�0D��)|����ZҎ�(�%Cn�1�?Ǩ3���Em�K��T���)����������),�"hF�G�h˅��=����Y��6v:nt���Ia�o����t�槁C
�8�s�C>�y�,J�!���;���	��K�w�tK����њ	�'s�d�S�5�'}S�w\x�X�Pj���ŷvH&@aG�@��G߼3x������P����g��Z�J������qF*�B��v��,�~6����G���ԄR@�f��<�B�P���+W����)��ހ�J%�d�3����7^�
Sk'k�u�.ݏN&��U�ܣ���'ēF*W�{_yx�[HM�(*7��6R�W<�i�0�>��b�)	K�坾:��	Θ���_�X4e      ?   �  x���[n�F�gzZ��ua�z���@6�n$��C%Y�X>��w[?��^%u���|8�6|��x�yz=-�-��{��:|ͻ���1S�R�޾�?�M?�Z3�m(���0�/��s�
�4u_�o+��w�k$lc�>O�?N�?�[lab��U�8��\d�[Ȭ��}7�Zɶ�q4�T�-v�����Ö��~,_ku�����_���>���c�/�[.��y�;Xk����V�1����`�����f�����̵�{_.ˊ떆�淅A����8푅�׼�m���>O�G� K�kkYI�Y���&Uicm��*���Jd+-P�6u����2��]3Ǿ���H�T��,ͪjV�B��y�������ff�3�����˵�l*��r���5U��@`MZU{���-�Z0�����Z0�j�
mp�4��wte-��c�zw�n�\���y�6��g3��FE�y��߸�md��,�C+,��WM��![��v,�ߖ���]��vE"�h��kF\��.���Ϊq�6�7�ld���B6RNՠ%�f�E�����B��G͆4Q��n��~X.󯻋��F�P������FX�T��[���-�͠��u�Z>�?6�G���%V�R��у�7Ij�w[�L��@X�,?]�݊P(,Ղ[��P[Q�5n44�D+nt�k;܀(�wp4������ ���%[�.������C��эs���^ ��1�G5ݱ��nb��|"ێ��'س�\���;�=�+RU�[|���M7�p�,�+e27U���9�;+�=s��n�����]�Գ�L.;󳴱Yp�\���]��^����c&�e��̵�ѕ4��Ja'�}z΍pah�M���[\� ��\o�K��w��"| N,4x��r��k2<��n�'XC��6#���\�K��妻Xܫ+.2W\dn$4��>��T����]�u���.��ц���l$�`�պu4W7݌��M7�M�	)W"{Lӥ�����״N4�����8(��1���fp��=�Ƶ�}'���ܖ���#�q��"K�~��P�O~n��]{�ېd��A��S�����;a���C�K5��(|߳���S��R��n�_����@�n�7�6�V�������E������;�w�<�t+�C�\?�]���{8�	(ǽ�
atn��5~=^~�^�<RQ���NduV�	��L�	��ԥ;Yd.�¾f֯�����*�\�\���b5�VuM�������m���*-x�(���l���vh���`���|̻��?�w9�FjPu����8/����Wپ潂6���[��6V&m�V��m�Ӫ{�m܁���f�p�^�x�YaC������|��G��UL4Ҁ��k������Y#��&zU/z7BV�wd=K��}̟���v4SÍ��ZYp�6T�I�*zT�6ּ�نh�+ku�l6j��آ�-f71�uᩬ�n��E�v��ޔ[O�Z�}p9s��P5���v�k�n��ܳ�۩{�?N���Ov檭�F��ې�`_{VEK՞j�B���Ca�%[Hn�;d[J�-*�S�6�"}�c��$��u.�'7�#{Z����N}?MEgS�D���"�+X.� �]��[��v��@e�QwF�����B���-��xܖ�Xl�i�;��
����l<ؑ��"s��mbdwn9���\Is��\A]�����]\�|"���ԽG��eo����[7�t��o]d={�Ǖ����j��
�f�f�M��t���"s{Q�\<��^Bl��Ud��T���V8\n�n�I���̵.28�W����e'<\&��xv�����x��-���a��UQ؇�*�R���]�wj�[r[��x�[Ss{e.2x�#�{�m������+��r^����n�6�!Qt� �!��n6g��e��: 5�$F��t��.�zv�p��v�ͣ`7�Fn�.��胛�%�޵��n��e�iw#ݓC.7�;m�-�D+��|�?�?��n��n:�Bs�M� ҍ�घ}`V���Vd[Gp��[Ep�Una��cw����H��f����EmG�3��\���VܝT��<���]Isi�@b��싋l���r�������m����S�w\�\����egr�st�L���C01�d�M�ޭ�Fyvnߝ�����m9�%��g�ٰ�E�h���˨�����6��eg�V\��2�����jR���ʙ�v����\n��,�f�4qg��r�B��Yt(��Jb�U��s�l sw^~�����J`��3�ō"��P�Lve-Ln�Fw� ��|_�ܾq\isS*����M�`':��{������{7�]�*U���&n���k.��W����.�9��<]AK씚�eIl}9�Ds�~F*�nн������~��;�d͍���&��'|V^gtE-���
��M�O�"{��n�^Zt�9�+��ehb�'���:�ҝ�k��+�� ��"v��#Ŀ�
���|��ɲFn�wS�P\l	�ֲK6Z(0K#L��&{k�FFp�/�aiss�[���V����1�>�����ݾ;<���W��;I�6�]A�I��3�[���bi��SU�;vר���^?v����R]^�uU�5k��	vSn��.6����.?˞uS%��nb�z7������i\��;�ar�mtCI��O�ٚ�ލ���T�]T
�{ǡ��2�K��:�0�&[qC����hvï��]����5�T���=�{���.Sp�.)�I���C����Vjawt�-˧3WBq+⡸�U�Ov������J |'��F7���`7�{��&����r9�����ܻ�#�*?]d�� x�6��q�ކzun�E6_]�ڇw3=���jOd�G�"\�b��p�;���WWC!�@�{]��l�B#��a9�~Η��Dkj�;J�J|�lt�o�)1L�o�Dl%���2��^�z� �	���V�Τ�%��:w�ؗ]�Lf�K�������_�z�      @   <   x�3�tL����,.)JL�/R��2�t-.)M�L�+I�� k�9�2�3Khk�W� ��0      A   E   x�v
�t��V��424443640���q�qV�Trqr�q��ݜFƆ���F�\1z\\\ �"X      B   �  x�͘Mn�@���)8A�?���Q20h���z�s�M.���)�=��l�g�~�w�y.�O�aqS��KU��Xw�����}g�o;����3饬z�>9i� �9y	*0Y+di�U$�	�<���x:�YW8D���1�q�/EJ1h&2HB{�S��T>�0��Z����6���;�>�<h\y╯�k@	��a`�X����;�'���5�78�ne��ɬ�A�^�8D�"�{���ѭk-h s�'ۖ'�=�rƆ;�y�A��!huWZ� 	u���69>��z��BZ�^U~�Y�[� �5��&�A���3C��V�7�kFlQ^�l��x;�B���B���X#��j������66L㭟l1{�sXN��n���ad+���y�\�2G4�ﶼ��X�r��8�DP�U�,p�"S����8{v��Wa��獈~\��`      C   �  x�͗Qn�0D��������B��
025Q��n��U5*�c?�ڻ�6~f����]��J��NEU��z�>�~�K�̒_V�O��cғ+kj��42�qu<����A%��L�5�1�+a�yv6�3ȩ�k��KQR��RЊ���t���s�.��UM~}��Ƈ���҂���<��w�6�gA��V
�Ď��U�J'-� �i���I&�rz�b�c��h��
�]���,h�wZ�ٖ<���ؖ[�0���'nu!�����9��&�Y>���7hg(~L<��$���@��j�y
&|4�E�Y����)���9�������0du�48L$j.���3�����Ƃ�����l1��1L����\-h��&9wٺml5�&BcA�D�3��t����p�&����i�5�XBg��7����}��&�7      D   @  x�͘]��0��'�`���$~4\4C�p�;���QO�HTY��ʧc��m�:<���ݎq�����K꿛D��C4�����0D��h�V/�<�y<��n�'�;�����R
Ԥ�
a>ٜ��K�jU�s��!���E��y��J%�Dd�����}�� :��Z2��s/V�*YMv1�`ƹ+{��U$�k����(˴ޯa��e�S��,�r?U���%>1�/;�.�X�/�w���/wb���;������V	�|�M��y���uZ����E�g��^q��~>�����9�K_#����\K��d�}'�{�,�̟�Yvij�?� F�,�֐*����}�?����c�����}vز���Yrb�-������x,��������~D�Й����S{c:y7l�*x3%ײ���Ix�l^'ޫ*u�bjY���D����g�|Z�y������1SJΛ/����۴��^�42�	��dS�s��\�E��J��M�F#�-�zow���1+��E!l�\%<Y
�2WieI h��,���>-<��̞N�&��"���my�Ё����B�      E   �   x�3��/NN,R�-�447��05347��%`�8d��&f��%����C#c��f	�!W�gVbYf*��5F��f�&�4����Ғ���l��b�X����*���d	$j
RRik4����[�0f�>�q��g����� Db��     