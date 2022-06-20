PGDMP                         z            Data_integration_Project    14.1    14.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    17416    Data_integration_Project    DATABASE     e   CREATE DATABASE "Data_integration_Project" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
 *   DROP DATABASE "Data_integration_Project";
                postgres    false            !           0    0    SCHEMA public    ACL     &   GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    4            �            1259    20069    azienda    TABLE     �  CREATE TABLE public.azienda (
    id integer NOT NULL,
    n_registro integer NOT NULL,
    nome character varying(255) NOT NULL,
    data_deposito date NOT NULL,
    luogo_deposito character varying(255),
    settore_produzione character varying(255) NOT NULL,
    importazione character varying(255),
    nome_marchio character varying(255),
    data_registrazione_marchio date NOT NULL,
    descrizione_marchio text
);
    DROP TABLE public.azienda;
       public         heap    postgres    false            �            1259    20062    comune    TABLE     �   CREATE TABLE public.comune (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    cap character varying(255),
    provincia character varying(255),
    regione character varying(255)
);
    DROP TABLE public.comune;
       public         heap    postgres    false            �            1259    20083    itinerario_aziendale    TABLE     �  CREATE TABLE public.itinerario_aziendale (
    id integer NOT NULL,
    tipologia_itinerario character varying(255) NOT NULL,
    comune_id integer NOT NULL,
    localita character varying(255),
    latitudine numeric(8,6),
    longitudine numeric(9,6),
    note text,
    bibliografia character varying(255),
    sitografia character varying(255),
    url_immagine character varying(255),
    azienda_id integer NOT NULL
);
 (   DROP TABLE public.itinerario_aziendale;
       public         heap    postgres    false            �            1259    20100    itinerario_culinario    TABLE     ?  CREATE TABLE public.itinerario_culinario (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    comune_id integer NOT NULL,
    tipologia character varying(255),
    descrizione text,
    note text,
    url_immagine character varying(255),
    latitudine numeric(8,6),
    longitudine numeric(9,6)
);
 (   DROP TABLE public.itinerario_culinario;
       public         heap    postgres    false            �            1259    20112    itinerario_culturale    TABLE     �  CREATE TABLE public.itinerario_culturale (
    id integer NOT NULL,
    luogo_interesse_id integer NOT NULL,
    comune_id integer NOT NULL,
    via character varying(255),
    localita character varying(255),
    tipologia character varying(255),
    informazioni text,
    note text,
    bibliografia character varying(255),
    sitografia character varying(255),
    url_immagine character varying(255),
    latitudine numeric(8,6),
    longitudine numeric(9,6)
);
 (   DROP TABLE public.itinerario_culturale;
       public         heap    postgres    false            �            1259    20076    luogo_di_interesse    TABLE       CREATE TABLE public.luogo_di_interesse (
    id integer NOT NULL,
    nome character varying(255),
    tipologia character varying(255),
    secolo_costruzione character varying(255),
    prima_attestazione character varying(255),
    stile character varying(255)
);
 &   DROP TABLE public.luogo_di_interesse;
       public         heap    postgres    false                      0    20069    azienda 
   TABLE DATA           �   COPY public.azienda (id, n_registro, nome, data_deposito, luogo_deposito, settore_produzione, importazione, nome_marchio, data_registrazione_marchio, descrizione_marchio) FROM stdin;
    public          postgres    false    210   �'                 0    20062    comune 
   TABLE DATA           C   COPY public.comune (id, nome, cap, provincia, regione) FROM stdin;
    public          postgres    false    209   <                 0    20083    itinerario_aziendale 
   TABLE DATA           �   COPY public.itinerario_aziendale (id, tipologia_itinerario, comune_id, localita, latitudine, longitudine, note, bibliografia, sitografia, url_immagine, azienda_id) FROM stdin;
    public          postgres    false    212   �=                 0    20100    itinerario_culinario 
   TABLE DATA           �   COPY public.itinerario_culinario (id, nome, comune_id, tipologia, descrizione, note, url_immagine, latitudine, longitudine) FROM stdin;
    public          postgres    false    213   �G                 0    20112    itinerario_culturale 
   TABLE DATA           �   COPY public.itinerario_culturale (id, luogo_interesse_id, comune_id, via, localita, tipologia, informazioni, note, bibliografia, sitografia, url_immagine, latitudine, longitudine) FROM stdin;
    public          postgres    false    214   \                 0    20076    luogo_di_interesse 
   TABLE DATA           p   COPY public.luogo_di_interesse (id, nome, tipologia, secolo_costruzione, prima_attestazione, stile) FROM stdin;
    public          postgres    false    211   �       |           2606    20075    azienda azienda_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.azienda
    ADD CONSTRAINT azienda_pk PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.azienda DROP CONSTRAINT azienda_pk;
       public            postgres    false    210            z           2606    20068    comune comune_pk 
   CONSTRAINT     N   ALTER TABLE ONLY public.comune
    ADD CONSTRAINT comune_pk PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.comune DROP CONSTRAINT comune_pk;
       public            postgres    false    209            �           2606    20089 ,   itinerario_aziendale itinerario_aziendale_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.itinerario_aziendale
    ADD CONSTRAINT itinerario_aziendale_pk PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.itinerario_aziendale DROP CONSTRAINT itinerario_aziendale_pk;
       public            postgres    false    212            �           2606    20106 ,   itinerario_culinario itinerario_culinario_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.itinerario_culinario
    ADD CONSTRAINT itinerario_culinario_pk PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.itinerario_culinario DROP CONSTRAINT itinerario_culinario_pk;
       public            postgres    false    213            �           2606    20118 ,   itinerario_culturale itinerario_culturale_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.itinerario_culturale
    ADD CONSTRAINT itinerario_culturale_pk PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.itinerario_culturale DROP CONSTRAINT itinerario_culturale_pk;
       public            postgres    false    214            ~           2606    20082 (   luogo_di_interesse luogo_di_interesse_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.luogo_di_interesse
    ADD CONSTRAINT luogo_di_interesse_pk PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.luogo_di_interesse DROP CONSTRAINT luogo_di_interesse_pk;
       public            postgres    false    211            �           2606    20090 1   itinerario_aziendale itinerario_aziendale_azienda    FK CONSTRAINT     �   ALTER TABLE ONLY public.itinerario_aziendale
    ADD CONSTRAINT itinerario_aziendale_azienda FOREIGN KEY (azienda_id) REFERENCES public.azienda(id);
 [   ALTER TABLE ONLY public.itinerario_aziendale DROP CONSTRAINT itinerario_aziendale_azienda;
       public          postgres    false    3452    210    212            �           2606    20095 0   itinerario_aziendale itinerario_aziendale_comune    FK CONSTRAINT     �   ALTER TABLE ONLY public.itinerario_aziendale
    ADD CONSTRAINT itinerario_aziendale_comune FOREIGN KEY (comune_id) REFERENCES public.comune(id);
 Z   ALTER TABLE ONLY public.itinerario_aziendale DROP CONSTRAINT itinerario_aziendale_comune;
       public          postgres    false    212    209    3450            �           2606    20119 &   itinerario_culturale itinerario_comune    FK CONSTRAINT     �   ALTER TABLE ONLY public.itinerario_culturale
    ADD CONSTRAINT itinerario_comune FOREIGN KEY (comune_id) REFERENCES public.comune(id);
 P   ALTER TABLE ONLY public.itinerario_culturale DROP CONSTRAINT itinerario_comune;
       public          postgres    false    214    209    3450            �           2606    20107 0   itinerario_culinario itinerario_culinario_comune    FK CONSTRAINT     �   ALTER TABLE ONLY public.itinerario_culinario
    ADD CONSTRAINT itinerario_culinario_comune FOREIGN KEY (comune_id) REFERENCES public.comune(id);
 Z   ALTER TABLE ONLY public.itinerario_culinario DROP CONSTRAINT itinerario_culinario_comune;
       public          postgres    false    209    213    3450            �           2606    20124 <   itinerario_culturale itinerario_culturale_luogo_di_interesse    FK CONSTRAINT     �   ALTER TABLE ONLY public.itinerario_culturale
    ADD CONSTRAINT itinerario_culturale_luogo_di_interesse FOREIGN KEY (luogo_interesse_id) REFERENCES public.luogo_di_interesse(id);
 f   ALTER TABLE ONLY public.itinerario_culturale DROP CONSTRAINT itinerario_culturale_luogo_di_interesse;
       public          postgres    false    214    211    3454                  x��[�n�H�]S_��b�ȂH�!M�ض�`K�䪻�MZ�U	H��L}�,g}ww�?vOD&_2)���ؔ]��q"�Ddhh��ȱnO���|���՗��p����n��2���j����,{<�����pb=���+ܦ��;���L#k��G)���3ǑeO�Û��ƙX_b)�'�g��u���b���-��J��(�Y��Iq��1*~�R���]DJ���e�I%�5���JD"��,?�gs�"Ii�7,)��Z˿�S���;�M�^�8p$6�2+K�DlTvH2|�EJ��V1��Kz^B�c�����?�@��X��!k,��KwT���h�%m'
T,�4�q�hг-��Ɵ��d��훑�y;����)��Z�����@$�	�2���C*�Q�M�Á�#��Fnw��,ޒx���	%��s����[%ۅ��l�����%�CW�ԍG��P��b/�5�x�'�j��b�C��N�]RG�X���l f � M�8��k�2�jI�0�!٫Σ����}�q��2%�x��?�f?����ny��?��c�}�c����_�h����6�Q�V ��Q�Y�����&"�n�t&Xa�c4��nNQ�%F�3��o�8��xUZ��_�dK�4��+���0q�vr@���R�:=vR�6aGWl3;��l.�.��:��6V�m$D=��&9�<Y��$~�3�o2 *��8YG����s,?��V8�[N��L����PL�� ��+k�r��yb�67Ϲ�:C���K`�k��2agWZ����|}M����^�'���I�?�	��'��ʽu��)|,A��5^U�?�!J��A�����#����(���0���N���� o\�-��!�2 ��h���X&i�m��b�K��I����T�LT #��yX�r(8ם�
>�F2Ff9x�"�q$������5�'��Z-ngӗ�Z���|����v��!�0<���i:	�3��j�[��3 � �"�������	C��G}B��Z�P$=`2�QT���JI�T��@aTrЫ@YrJ��
�U�g9�k�[�=�X꣌׀!���5hI>F	�ݵ\#,�}��(D��"H�	�u��?�0���:v*������<&<A3B����`�1PLnt��8��U���XN���X���g�����0@~�T����$wxr�tdX�7�Q�$Ӄ��Z	e��Ș���8�5��x���Hjb�!� �ȳܡ;Y����q*§_�����1<jL��
	�>bD��D	��
�S>��N#�3���1:sY)^� �(�ȍps�V&�F2/+��%U��o�#{�Z�N�ӻ���B�Bh8�|�Biw�AR�r`b�ű�%�f�w���X����`�2l�Y�����ְ�X������)C���DW���j��c�S������4���ķ��*�4��1*�è�bO9I�y b��֊���JA�q��%m�~ ��`T�P�PЦ��"9�L�r�m&!�V"�dEί��_�!�q*BGt�Q8cB�b�G@�-���n��ݗ��.���	��oSA�v �A�u!��e8�5B�$�B��oj��Ih�C�HR�g��Q�wƥ���p�R^ =��׫�^b�g�)W�	J�!w>NW�ŕ�pZ�ӡ���"�ަ0x�H'n��_I��.Au�Ċ�X�Rj���QF"�@��䈸W=K��q9p�}5A����P,OF���{7*"T�6��Q�8�I�Q��Ǩ�c�A�ʓ7L��e�F=��ߪG��#m�a�,St��dr{��b<��|9�]����b	�c���XQ�&����iP]�h�#�:���玝�غ'�MWXu�<�#�������&~J�&��ˑǶ�6�W-6���d�j'q�lDmg�o�����֠ѯ�W;��rh9OT�d��a�G���f�+Jߛ�GU���"v�r�Ȑ����^���_i���"�%	*S8��AU����@(�◬��X�����+ɞ+��x}ݨk�X\s����Vl �_G\su����%��b@}};�`0Ï��H��Og}�p��X�0�?�}ݩ�r�7M�3�PCҙ|�٩c��^H=k5R�`���>�*�,"4�����\"s$Ѩ�4Ȝ�y�i��5�ڬ�K���E�e��uA�>&��D�WE�"�IESEx�j�j5h��� �6J$njQ�U��T�N��sʻ���5U�F6%��_7[��$#�\�Y>�U��MtH2ſJ���l�żH�?!��x�0�3����U�"�,zyi��Z#��8�sk�h9}Rt�}�PZ���)[D���^B�׸�#��Nq�	,ϞL�c�GI삇���g�Y��-*J:7�����)"��1#���>��Y(h�]��by��_j�C��Y���v�����D={̢���]ܨxІ����-�ɥ�0���F��{:S�v������d��{1�����)��X��c|�*����|����5�J���Ґ*g]�F# � �otZmR/��Z���2��m�|�?r�	�NN��8�j�����L�-��`&P���BE�2� ��e�0%ף3��T�.�_��D���8�ڵ[���W��Y^\D�=Gj�i�� I�<6�/)��v�6#����mPw���l�əm:��e\��d�~�Wlܤ����4�=�T��ZsIk�0�\�>�h���)Y��59ʨT��Y	�V6�\q�R��F�*f�x�Y�D����QᲹo�Z@z�Ȳ��3v-����C=�h:�2�s�?D�\�E]�ЗRa��cm�Wu�+��*��Z��AC
i�B �&C������b5{�Ѿ����t�?������
Bj��;��֠$���::ig}�=׏�eK|
	w��9��	��!O"�r z�A��"�v�
�/�9����K�$� ��Է�N�%bI�9�]D�ˑyd��ldЧ�]Д�����7�f�į*
��9�(����AO{N`��;�=��W�'�!M�RvkbmU^��	��h:�i�wky�k��H��-�k5�0ۅ�
��pո�*y>���ؔ��߳Ҷ��z�#?�]����#�j�O��V���L�z���E¦��.GuW�C�G�9
.�`�Ý�n&�����T)͛G�t��н�����z��fӪ���� ��A�*��������e�n�ֱFgK/T�:��F��'����_<"�<V5f��/�޼@���~/) p��!�$��yY�ʘ���v��@N@�^���'�f�a:��K���r�80��\�q��5��{Md��}-�^�I��f�H��{ ܁7�쏊MrQd�s��֋M�Y�����:����R�3O}�A�|��)H��y���\OB-�f~_��F.��ۄ%��� pQͼ�":e�^�	zI��N ���'w��J����~7-6\:�YUD[p%K[�bL����--M1PH���-ڃ�H{���3J�3nO�s�����:'����Z�������'�v�-�����.?���b� ͘��S�%�)0m���%�R�3��-�Z0/Óf���!c��(mƾ2!\n7z��`f�o�ǽrwb�p��r���
�+(R�̈��, �|TZh�UL�*!f]�'}�T���35'�D�y�I!s��=�(��<��,8
H=��ݏn�gZ(6@�jd��j�
��
,/�������iTW��_���?�e��j�GZ�Ϊ���"�m��D^�z�@`Cǜfr���/�:����?��.��K]�|KC'x�r��/38U6Q!9��lE�Ů�i-!�B�`�HO��ZoqU�U&Bgf/��b����Z�p�!خ�%�m�<�5���nH&���8�t���:�5f%��몢3��7^�E);Vٲ�߃�hLQ�� b� �� ^��v4�}�~	��i���g]�&���W��v��w�9GC��ty�ˆ���e��ġ�*�%�������(��:@>EG��[�%��Poĭ�Q��~��[v<OI�)��l_ɴ>6�|T�%a���M>   �빆�P���8 Xf��9�S�r����V
� t�1Ꜵ���}j����ƽGgpdbp��w��J��>��~B���)��ю.�T��i Y\M���=wlَ;�;�<<ϸ[�����L��4?���n���n��o�����<�SN]�	e�.ف�����Lkؼ�ϳy�ey��+�ɜi�.���"�uN& ���?�m�!�vl�a
��3�b  �.|_@W��Y�ȏ"�v���^��7�b����T����v��w3�\���[Di��e��H�2��}�7�PRy��2�v����S����P2�䛡TR��_��^���S��lRG��]��hL�^x�ΪG�&�o���}m	��h�=B��C
��R+��dG衤�{�vőm�ן���(��<�T�IM"$y+]g���o��&Wi��".���ա�z���9�q�n��!��Ǯ>���U_k�v���p����8���4��u�`Z�����l������<-t3�Q��9j�5�)*ڀ қ�ê%�>R"���'&f���-ܩ�48���-�gF��t���JT��g�M���S�7�ۋS4��xcҔ7����l��L����C�Cfu'cԕ���	yZ4b����f{ne�F�D��}d>�����&�w��JE��M�VE���W�<#�D���W�����͎������h��k:�
���$���@�t6c�0�s�zi4�Q|=~Y��)m�^@qʖ�R�6�$u!��7d�f����rv7[�C���1<z�+�,��457�tS���G��Am?l/����8uF���[���;(Uf_V���i��*�Be����f8�_�~O4x�h�z&�\�x4ܤ�x 
�5WJ�9��ِ�G_�0��H�]�N�T��u T���	JX<>�N�}52S?���<��?���������9�Tn���LhkC,-�Q͟ �ԝ@�_r�Ձ�!�9ð�zi�F�{>�Ŕ��)h~��'R�o�^����'�>         �  x�u�?o�0����֭�ǖGEH�N�*���"1��h����=�0Z,����y��T@7�}'h�Bk:�q��B���y�UDE�J�>��.*��_T����-��)�ey�n�JH#�U����EB�����"e�������xq��T�Bo<2f^r��-#�ɐ:!S������O��}�رɱN8M(���:�KW��q��Z�$����&�m�D�j���Fè�/���\��wհ]�Q5���2y5��d�7櫏pƏ{T�iT
8��<g�R���Hw���~�gHSV0�^ht�|��uʥG��g�u��hRd����<#���y����DŪ�[�Q�}�|�X�1R�b���x���&��la���U�q��r>�2�I��w�<�"-"�Y�M.�O������ ��$         %
  x���n���ͧ��[���?d�#-��5��,0KgZiF�] O����r�T�Y;+�nA �}��M�;�䈝]5uWnwM[�es���/���릦�j�k��6�-���M�-�V0D���h�E�U����+(�KY�����k��ے��}ٖ�������[�5k���Qz�U���עk�l)�7���Wͮ��f�-�UU���X����f�t������������+ۯ�'���vX.����X��e]��7�}?sQu��v�iV�f��G�uU,o�����v���&g�-bL1�r��4���_>�_�RΘ������i������{�.s"��O��-��)�ȴP̞q�0*�"�	�HU��M�Ӷ�"	��_� ��"~F�k��~S��(��K1Bi\�����<���tE�*T�ߕ�������U0(ϫz}�������^5��-@���5ݗ+�)����nV���c��l�4sմ���mqW���@;q�+������$`�t�[P��K���x�����^Z{��R_�K�xi����|T.�N�_��d@���"�z��
�n�!��4�rZ�}CK���C��5�
q۲��u�ٜ��L���?Ýf���)�@Q�\Z�%i]oZ3��ZOQ5�j��
��݃�F�dS���,��,WL����i�d�&�����FE�k��"s/�/��\I�/J�a���_�!��\5��A�� D?l���ܔtIo �����JЂ�5�S�wB�;�TR�gEׁ�j))>Re������ڧ
6��Af�dlT?����5,�kN��ϕ�~�ٰ�I#b��Y⾑Z��lx?e �����$�s6 ���Ǔ����ϲ�&����$���s=2�dP�,��#<R��B�Do�v)�|pX�+�#�#�$�sY0	Nx�xI&q<���ӎ�t�!.��� <^{���<�EY���&xȐ]qIx*��0G�+��z7����8*�#eW��V8��!��?N2f�=GMx�`K�g8�q��[S�;.(�r�1�i1Ĺ��8�E��H�����SKd��ikj��9��ȭ�0I����LƦ�
�i(�⍀X-���;���U5|S%}{��ɠo����R���dDڠ�i�$to�`D�Ov�WB'X�V!ZU�L�������:.G�� ��Ư�3"��@�$ǰ�kGB���8��]���tY�{��9��DD+'>�Qa�J�`�8I7\љ�xf������r�:LZ��@���+&�{E����I""%�kL�I	��
/�Suaғ�uL��:&�k^��M਀c�P�23�e�(µ6	If��K�
G	���=�Q'��l����ݾ#�!����ih00a���'0/F��X���M����3M�|��H��:�����Ʀ"�`(3k���tB�x��R�"2R�����w�r�1�[>D��ωp�J"#EXbp6��ťb<�ex�?є�#5����k���d�9wY��]^I�W2腴��(c��	HAd�XN4��ce2؆6�um�Y^\��x�>�9T�zL4��zY�;����!Z�d�M0%����o����x3~�;���y��+z2#*R9���\�Sy���eTX�L�`���H�qU��P ����%�Γ-?d�J��S��}�p�<��F6�Xu�N���,ߓ���@�B)}��H�_��E�U�r_�;�۳-��~C?���ެ˻MO�6�;��y
������[��߅-] ����	���C����]J�t�	}�eΙ�1|z�#�5�Y)�"u��~����F���������i�BN	q1��G��Ps0�+
�Y�s�d���pd&Vm<�1�?�Ӽ�7�^�`��(ϝ���0M;M|6ʤ�ᘂ���.]��~�f6��\(�]q��f��&,�DY�"�����w�W>��K��4��B���#�n��rD������g�c?q��a�vȇF���`�Z��S�F�KA Y�&;��:kZ��n�X�m�P�0����9+��{��Q� ��K�'��e8z<�N��":R��6��p�2LSN���6o�%����7����#��6��C��`�ł�D�&<�5�)]AΡ� F�s�_	�j|G�`d:(ц��G���T�Y�3����1�-:���\�#|S��2�?��D�W`"X�uF��V"�d,cX&!��.�����=~�^ nK� ���@��Kw�����`)��LH	5��|�M���)e�����qT9�M�\�f6�9Qoˎ�H�4�r�
��
u����9{;��6��0bb�8��`�S���*�2�*X���p6��]��F�+�CR�'�@&��7 ��p�{0��w�܌$&R %c��\���ac���`ӷG�����/�4�8L�z����ldz]�hb��ю:�(%Ox���	���k�ީ��s�Fp-!�CL�d�`����\�+R��`�z_���m7d2�j��tҿ�33�G�	���4�'��N�ɈI�;/�$��ዽ<�R����O[�˂�oxW��            x��Z�rɕ]�_���@�իu��#��
����DU��U��z`��?c���g�݌wҟ�K|ν���C�V��̼�sϽ7��_|jgއ��&�����������c�������Y��\�:T��,�9�ֻ������Y<����s���1�V�������g��s�.�=��Mz�c��Os>7�Ͳ{?�Xqp&���{������WMh�i���rme�=�L��\ȕ��cnrk��_,Pylv��ᱍ�������X�͗����������������~�u�/O�]kOZ��}E*��\}�M���CM��B�ߚ����l=�����~�2o�R�M�rL׸����+��-K�b[,
������j[���I��s�P��
PE�j(�z�N�z��=<P&��`?Q?R����y��{Q"�Ap����}P���J�i�q�\I�����
e#2v�6t<br(��*��|nU��v\��Lr��U~a~��0�e+�j����b3�ߛ��Ǽ�%~f�\R���rhu%����9�+��_�J��G��P�.�C1,�L�S%�w�¼����^�Voo�*'��)~0������.�W��f��^��˕y��}�c�n��>�QW�Ŭvkyz�(-J�o�^������wo�vM�9N�wu���[�߻��w��+[��u;{yu��q˃}�Yn�7�|���v�|��o���������ж<��?�b�Y.�.7��z��,����j}����Jg��E+��D�H\?~,�S�.����w�5��eď! ~h%*�> 6o6�[>}/`׷6��Q��[g�j�ߙ�����.������5Qv<�ߝ�b�����B����ߙ��D��pӋ�������p���̠E`"ޣ
l����5���p$,FM4�ޭɉ��Uu��9�:܈�:��e��0F0{_�_�*`��s���Є�/�_���1�u�H����x3yuO���s-��Q�%1f����=�C8b%E��yY�:��`_����
T�O�@��w��`�.y1�(�tCEK` k�a�^�����%[Y�|�x�u$� :�'�I N��)���Q1���'6��eV��@��\��/�9�?<G�ۨ�<SJ�<a:�i?�.��3�~�a}g˻�`#\no6��Wgk��y�)t~�����6Y%����>���2�Q]V�������1�	�D2��--m��b["�>��J�uYh&���.CHz������O��O(����P$��pX	'���oϹ�E�| ����*R!���7Kw9�}{��R��v����������7��<>��7HԤ$�������1A(j�%x�%0�
1�/��@���Lq�(�ɮ��"f����E�{��	 ����?�4 0@=~yX�mΓ��]hmr6�������IaGh'��34�v�Иn3��N2 !,�d��%nH�@k����\�����K�5�<�7 Z�h]���]r�<fΓ�G_;�7K&[ +��'S��L��|wC�BBL��R�Ƶ{��9�����I������c-����Cg
0׃����H&���s�;n�F��V��r|I��堨9c�F�#�@A�+�<#m�;3�:��WrE�V�0wO���z��BK�[�������|�~�hj������K���j{y}������C+1[m����5�OpX�M�k=l���A�i!��i�Ё�j��C]�C?�� 6�X<�S�����kD���Zz/���$��!ed=�4�>V���[��=*�ா�
�r$!.0;i�>CƵ���K/MV=�Dpg��{ɦJAb��'F�2�A\M���CJ8�T����I5���R��LG��� gH�$��Al%)� �E_`�����+`���xDb] ]y��bb�U�@���L�!r[@��~�P`�d>�ܭ�EYb�L���$2�<=!�r��rc~2�������J�����W�>'�B����:�u!��B�4^U���T���X��H� �^*�EY��c\w�Q� ���,HmL�J��� �ť?�s7L�}�JeӀC�M���%�^v˃S��xxf. 0~D��\�$p��;z#����#<.�������X��P85��N��"�����S�D����7O�_΁ǜC~U^�{���R�6p���b�d���1�j�5h��q;�����F?Qg��I�f��X��t �D�zo�̝���]�~Byhz�P�&	������2X��p�H����?���&P=	#ݚ�ӃC��P�K�PѤ�I�Y�2�N�bg�pD�Nބ
x���)1��饈Qך�+�`G�)ʸX�l�1j���
�%���,��pg�6i���"1�{181�)o�p���<U߉oԲ��j/�'�¤�����=��<J��&�D��<�v��o�S������3�q*�q�"��`z�ZnV���n��-G�]n�+���+Mg��o�P�ֿ��߇Է�!�sԡ�z�+���L" #k�i���<���I�/�`�cL3i3��,�X��S�%�I_����%�x�m�%����`4&Gm�D�O�&���A�[�u���A������`ϓ���Y��k����y'pa��#%l`��ՓZH˺���bUM���{�{tm�x�\�����lIl��_��z��CqM��gJ%K�¯%&�-�<�M���T��\Z�Js;�۳}5I����a'��"�y*�	M3H�W�9�:1���o�G���?؉mm��	�6�q�39���̓D# ��՞�]���"��HI4 ����À���H,4�_���'Y�aè理�'"�G!�e�n�|�(�5��QDe'PJ��Kz?5ˠ� h��~���r��e��9F��� Z	�rR�9g��7P�,�o�~wa!w��(j��}.tP"S6H#B� 5&�*J�BhN�F8Cr�����W����r��[-׫��zw���"Tn��V���r�`ޝz���r�H��٬ήf�2t�P��-�l�{iЅB`�<�U؛#�&vmW����]'����N���]�#7Q1�����z��6�8���Ku߃Hp�S~+?�_�V���j[]Vi��:�vi$.q"�Rġ�m�;�@-+�>�J� �t��@e
%�AV��w]Þ=��&�`��"HZ�b��$�����<1D?��� &��hC�T�V���C�!*������r}Zk���h���A��;����~y��M�����5Ӿ�V��iD��{��`g�]^��T�k �j������Q ���&M���I�=��W��.E�7
l��h���G&il�G&��>��C)Ø��y��}˴F�~��P͵"�R�86e���#V�L����&-v�isj@V�h�
G�/�$�]m��{)F-k�Z|V��q���ܕ�	��3;�f4��Ƨ�1�b�"h�T�?�,�+B����e�˘T��xe�M&�:o�Yi�e��3�72n�Ejgd>���L�� �D�N�=�-��A�ސZ��+��䀏Z"2쟸≦w^12��I�6�����$h�BGz��{�Ց�>���i:���6qv�Qq$��>�3�{@)WG��*q���%���ieQ�	�H��F���,�M:����Ŗ��+�r!�^&� (��V�V��A��=)H���gLJ;t�3���t��1����V+�y�L��� 8�,�'�R3+-�Qv�7��H�&��� 3�F�?u����N��&��&;F_K.�1�-x/�����I(�����#��/�G����H������{�.H��i�K��n���#)��v�h?�J����N�G�B�+����"'� �x'�b�͐P�L+���n�Ϧ�׼����"�\���v���bQU�̑�Xӕ���,ڙ�R{����QZȠd�(�����4v�򮜤�ԃa)��$Z
�ү�;=�����\˽nHB��45��ʈ]2�u�W�UE@�ܻ��   F]>�Ϊ��/L�2&*X�?��֚ �t�*���x}���}�_�H$��������"��c�G�7ⳋ��e��S���������7<�����(�)~F��
�� sw:3��k����ǒs��ؐdm�ɍ��t�lR��e��&S�+�N?��X$�v#��z#6�zi�2`#�R�R��%��<L�6�Dxr5x�|�uxS�B�C�9��F?�|��n!��i�"��z�Q��k�噪��Rrl�����x��1:)���/h�����8��`�|�]�g�����l�y��A�u��Rޣh'LY��1��D��d��rj�T�J��C�o2��M�ㅠԴ�sw	�����X�mvk%���6���nv{Bx�b�4�~6{>/~/H�Y.���AD2��HTC��iE�+m�2�~�6O=��ؗ�������;#�k���M=o��X�7Z�=)ݗ�Ӌr�����9�,�洭�Q�'�P�wFG.��H��	4ᅧ�2��G�yP$�γ��:d/B��|T@f�H��sq��˓PDm�=�� JM�q�q<�XMP��-xQ�)�*�9�6 ���DAu��a��c�D�8�����?h��,�\,��bъ�>��G�w��Â ��	����ݠ(���\&��Ι��8]:Qs��'���t��c-��9��u�\4�@�*.������;_­���6Pb,�q��D��o��jdjx��.L��&VZ���F�l%E�M�g'����\{e�$�!⼰D��b�T�%7��cŋ��^�=Ŀ�V!�-��w`f�J؅8?��d>��!���>1�E,� �35'C�w�$T[?^��,�V)���}%���Bȫ(:�ɬ��� ��Jq�-�2"8hq�sq~m?�Kg�Z��[�#��&m�X�V���*A�er�*�גx�hv�|��W!c�bn�Ǉ�|�@{�c&���0������L��"��C_�ٲKu���2��id��\� �8{�2�Ry�T��yh5�-�Daw�ڌ���V���5����z�Y��yqvv�/ '            x��ێ#Iv-���
G	PT�a0y�T�!dg]T���ReuA��� �L���;��'�����������3�S�_2{���ܜ��*]0����Έ �b�m_�^{<������n���ڻ���Te{t幒ߗgw<Uu^�j����2��m��|v�}U�̗�1��U���R�����*�V͹n}��ww��������g'Wg[W��:��
�����������<;�����X�;�n�5-����~�'��k��<O��%ϭ�����d�3�x�]}��3��.^���\O_]�,/�{|���J[.�Y�a4�?���;�O��x����vt��\;>��y-~��}q�����m�k��a�5��\j>�W��t=��G��d�Z�MӉ���>�>�~�KyL����k]m��Ձ�z�o\�7�����Ƚ/e�esܧ��A�>��	,�+�Y�S�d�w96@�;zp�R�P]~.������ae\[�W��͏����/����U;�V��D[Y��EX
��w�0�s[�a}�<]�>�C���V�w�c��5r��TT�n�[����DHFU}x��N���X�׼x|�8y�K��[ܷ���o�����N}���`�m��mu� ��v����N��bl�>?Sfe�O�!�6����U䏲��'�0^�z��̹��&��=�3U"����g��
~d׺��w���L.�K���s����c#_s"����Q|��9yY�
�Q��\�P�\ί��?����E%;��M<��G��7g�����(�1�'�d%E��b"95/,�k���;;�u����Ke~��eAD���J��UY�Y�A�l���6�����ϭ�EAjD���DNr~��ȍ[9ݣ��]H֠��J~�S�PȻ��9碟�B��ȣ�{v�DK��E�|�נ����������g.�����+�<��~/�*�~��d}�>yw9��N�������?��!D>����C+�6l�m����/��l�����v�(d����k�s-���[y�j(��Eڪv�s�'�m������}.��},���&�\|�
��jr���{�+.�{~F��>l����ˋۺ�Paݰe�gi��+ybyޓ�M�#�޶".��
��?��r'�9���4�F��$;Z��Yt���F��;����織W��2'Vl��R��TW�7��Ö��b*_���E���q�k�c � ��9���puy=�IH��g-��5��:ة6�S����gCLh��tC��B�����Z]���`�w������"����,��|I�8�Ewz��] ��S��U}��|ԭ�*~�[$"���蝰�PE�������l��S�\!�^���'��?��>ʮEE�ÜU���M\��m���c���F��`�Fx&YEu xpQ�|İ�P��ۢ�9]��[my�*��E"|X����7���G�)�� ���R�6EC�ڋ�����o���7�޾����f�>�+�M��Ψ}+�V�a�Jn�\;���]T�lUq5Y��<��qҋ��"�u��]q�ξ�/G7�,W�\�����Xv?Nǟ��O��Ƕ*Obw���M����@�����|��b=��&���~%F��w���:�顭���6��6���`헮���'+��d��׮���Yo��}{�`�y����P�A����h̣h?�DpUs�VY���B-wjq�K�D�?�u�;G��+aOiF��S�Y�k�O!?RE�.7�e�1�yN���E?���T�&���xtƫ���j=g��E��M)�R����BD��?�8s��rmw�e�E�/�kgZ��Q�e��D4 �9�����w�5����S-�c0"��n�^��w�Q�G�o��~���{��<���(N�w0�6ДG�=�0�BK�Z���1��W?���]� ߂�TM�l�|�������\`�ީ3_�T𮲢��Hq�+n-6CN[�͐U,Ո�3��V	����e֩-�Y�N�����=�cS5A�����j(º��>V����QE�;����3��Oε��D�,8W6'ȷ��UTy�b�<�C�:h�<O���U��#BJ<��!c�Se�7(< Q�"�>��0]8�?�s�*BYMV��ز6X�`�C`Ru������Բ��qt���u����,���ƞ��x��<�z��V����$���%/D��U����=�H��1�c^����j0��+����pO)U4������ػ�\)�����u�Ё����7�2.wM?y]�\�ZPq"�UqFxS�=σ\��Y۴���הo��DdnV|My������:��y�^�{@M&oPw΅��0s�N�軂L�.t�ta������|���gG��Aqء�.����牉�F�fa�j�(�%� Ӱr4�8L��1��������$��$A#��c#���֦jY�?����d2�pj��8�'��<|fN�_v�����m���Eo�IL�@�&�m��C��7d�G�^,O�&G���h#���֕�t�
O�uv�dp�J���^3<��½��R?�������"�D�EB�7#��l�����F.��f�[�ȉ�BA��F�UP����e��⨏�>�:{
��ac��e�5�q\?2�YJ(���n	�����=���j��l�]~@@��l{�k�"��^|�9���X �Ʉ�mK�"���4?*&��DtJ���pK$W�v�@��YZ�羅m~nv�w�E�0��؈�6r,�\8M�帞+�5�#���珢�5A���p��9܊C����������况��("�꣏Z�;	N�Y��áɐ|!_���}��j����D�Õz���F<��`-�r�_"E��ieA���'|��CL&���1^,&��`�����S���ވ����UP�d�����.w�v��ꎿ��f�B���d #�Q���q����y^��<��ʘ��8_ir�H~���]���Ǚ4w�nI�	J^>��!���/��H�y�!8)r���Vb&�*5�g��ă��L6�<>D��GދR���
f��f���C)fp�3���P����X��uAe5/�uq�����T�q�q����$�:.DD$�%�c:�	}������×\���!�6Ӈ�|cy��,6S���b1_ܭ����w�~�#��Uޜ�\?���t�����5�*�ϱؐY�4Iu�;���E߈ϡ�(+���#u��_x׻�	G�p!�^�&�Be��
T��NP{y�btňA��b���y�ߺ�PU1�-N��z6}��,�<o\l�+.�t3��6���|�C)v���"�o��\�}�Ȇ�Fm�6?�9}-��E��k�O�K+�3Y�
Q�1�/�ViU���g�QIz)$&G�ej&�3m�/��,�?��Z�\��-,�lW�'�z��B���z�����p;%.*��r��a� /`�����TL���ݩ�������_�������<�%���	�K�m��IT�-�\��pu��˝ԉ�Q��K�
�)�3�G�(�� ��_��C�#Oq������x��X���V��Z��,\I���&	�1��>�(���!F攩�Oᒞa�K]8��h!�?/�O��ܿ���������K�����\�Obh1�Np֦��j������e����3L�:j_�t�!��(O=Y/�\T_}pdmw���j#!Ȼ1����}Po�m��N-�T*�'n��K�.'&iͣ	�Χe,�P�3�p��}�j��N�����jO�:���M�k��%���}��&�h����ͮn=�0�Hi~i��_X����j����OE��
���bAvcl�[Ʋ��G��}<�
=/�2� ��g��$ԫ3�Vm{Y ��m�{�5�#6['����a�GH���#��X��by�D�+���?�!�EsӍ�}����a�J�g&��i��a�W��̢����=?�y���3�����q�ځE���R�.�7�9f�@���dR�h�./�+Ay ��>��p+<�4 |<�3�[�i�����T j���UX�C�p�G+��
�    [3�f�k����������'CP��7����b�C"�v`�Ԣa����������	��T�D��?��7�.��-��|�_�[uV�2"����U(9![�w��JU�����O�NWY^Q�zArW~S;n1�l��Hx(΍X�J�,�t?O�����th��U�oT�_|)���k����,����l�3U���f|7��k��K���0�3��_��~�k��/���l���g��S����AATL���8�Z�{���_PLC�Ej�U���|�H<��-�R���z&N�T�ϲ��S�x
T(�<=�!y�BB��9K�36�K܊�#ʀ�?-dW��������[��ߟ.ŧ�����"��DN����-����	e�(�O��HF�e3�e��8PBa��?��YO�R�,��w���R�;׷��ډ�ıw��3����U}&�"�ƕM�Q�2��P@�s�UK���WO�Ӻ�"ˆ!�Tn�HX����gb�RC���N���A�u��8o��U�Ҏ���K�o��_�LAי�V�m��6L��r0����4�?�oUy5�Іt��)�yuޢb]]��fn��t+9M{V��]����d��ՠ���	x���U�'�J�L9�,T22����.����׼��5Z{�����{&���;Z��r���'���Bw��&�߃�޵�����kс��D�Йf��4=��^2�^*�� d&����&8_�3,J�@+e�L4��}ۢlZ"M
�\���4+>x�D[1�>�Df�jk�W��ʚ���������{���$�Pȓ�7j�M��ҥ�o��-�YE� ������c��7}�&�L��;���>� �>Q���@��
?p��"�d6X�u{���k��326U�i��m���k�k�j�y�4�'�O�U�]>�e���4�A�:�܈�3����T���h��s��`4ߞEiE�X�`��^|�:23&/�[�f���ba%���*��F7G�����W�3�ؐl�L��F��{G��%!�3�_���b'N,
�&i�G��W��x5A}�%�!F�!Zq���r?޸|�0��f�e�zج���Xl���l6�O��^�� جgw��`!n�b��4�n�=�_�%�T����i*D6K��5���+�D�f�p�E*�N��"���h�%z���X�ߐ&�@CQ�i 7���ڵ��f�B�ň]�j�>���@l�i�c�U X�Ƅ����_d���0X�T"S	�Y�H���ie~�n\#j�:����m���9S��G�u狹�F"}9���Bo
�@Ȋ��e5��
2�Wǳ�'���a�Z�?!�i(�D`*�"x
2���F�~U͢:	j�_�<L���'�ŴT)7E�=�������
e�~.�(-�'}D*�k�CH�*���c��4C��xl�ZA�skL`�i\�XQ#���p��_c���'7�� ���X��!/F)c�E�	u�Qqgb6E�&����x��]��*aV�$"|��jy�2U=��Dʬ�g��!%��J^4�c(ɛ}�i�N"ӏ6{��X���s�_۷���/:v�G���8*p���UD3k�EM{�F�gKB���c�ժ�m����me�����w^����N>��\�S�Ǥ���ߪ����*�dЯ��j�r����_��@�� �F�x��D�F��SP�VAlѫJ�Ì��~q���Kt�c�����
�r�a�>@{|$���W%[,�ε��R-3�͏§��(�m�;��Қ$ޢT��@��d���`<V3X`���E���ذ�A�u���ž��`{(sm�@�;��^іp�ĩ'0�B�2t �Π��D�t�c�E�4#}�����X 3��C��'�����pD*� i&�쐚�H{�m��4J���C��V��;a�{�[ >���S�){���E��J���5�p�	 �Q�ct ��s2����H�6T"��1 U�Ҿ�N`�O�
2��#�:�.d����~�v�{���{W+�]�����`	Z�'�ݮ�.tZ�?�G�H�{�p�������Y��EYP�����_��\+0y�E�tM��n�b���wm���<�ATڍjgYuF�T�"e��؝����j�y�GUD��r=[<<��y`ٱԊ�Q+�����8��T�v��&����賞mfӻ�r b�ʰ ?XS���y��d�~�-�o�PA��d%���p�#K��&4� �1�����9�[��B*J��i힒��P�706�X8D@�sB�<��؋Pw][��� �c�/O���L )���+Vl��i�%��t�`M[��6e�5L;x!ő_�bB�Yah�"<�WRRD����~��ɋ:�LCX[�����������tw͟'��Ƴ�ɅE�S]d�g���im�{zUmۀ��:ębyPQ�Oչ�~_�Ћ�|���������Á���}�����g\tQtQ�wG4�]Ƴ��e��j*�m��&�E�`�/cH���K�����y�6l�7�	�,�[�ֽ���οݩa�9<�l5�LT,����d=X@9e�JV������X��w}����j���KKC>:F��Bq���=
>�~���Ұ��F^*��Bb���Lb�s���'�eYv#�E�5,���]Y,�W��@� �t-���:�*vۢ}�V�'��LǓ����d�b1��2��gZ��L���d3X,olų���7�v�3���{���t=�y���!B7"q�w�t�	z�>#�`vj�����Y׉5�0 0Q<U�O�C�lB�}�|x-���6z��1UV�{��m)f�b���)�2ʞ���p_�e�j~{_i5 �L �Y������;^�Mǃ�x0��U�-}�_1Kr��Sn���։��- P�渜N_�Nf���n�Dל:U�c���/��pvÙ0��A#�K�$��u�l�0�U,��U͏�4�J����K���H��� "^A��e����GEQ1!r@�m��Y�k�.�$��?~j�nK6��*��d��-���������$�^�$��w����m�nF<0<9g�z<�rc���O�N�2%�h�t5�����
�R���O�@9-��޹�߈ө)圥y�Ԟ���������Hw*��i8�6�Py��}eS{��Ym�v����дͅ>�B��9I�k#�`ŻĒ�~����.^���S���-�w��W��&���`>mV��6�M!M�;1���`�x�7��l������d��1�&$I/)O��&@$VM�nA���.I8�.��lFl6�I(�x���z:D�>�1)
-��d��U��S���sڹdP��VDK�InP���MK�KUZ�\��%,_6԰y^��ݺ����1}K4�J���*�*bK��P��,׋���u�\W��P�X2���l*M�+?�A�׏��PZ9T
�br�x<>�����Թ�/C+4�/s�D���%��>6�k���:�5[�;b�+w=�L��o�~�<-�U�a>Sg~Ya��t>ۣ��Z���s�i�ik)�Ccd�[�m~�m�0�Y�nˌ��2�(=�?�Lb�b�|���7XE��G��f��a^�6���n:C�p�s��/��Ys:�ǯ��%��Q��bqH�V&%bi� #ҷ�U[2 �P,H{)��"UkB��0�z�x3|V�[�����C�d��˥�EI'�P��f*N�Y�� ��g��Ekq��â�C[�OP1)��ˤî���~ZM,�f����N=��'���됡+�~��<x�x�_�yxQ�!@l�ic��eNS��~�� M��W1$��cS�,l5m�����38ďj�
�fϏ�B�Y�? �l�an�1��_�UO3����>?�c�-���((<xa����ll�bǑ\Jд�����tə���P:�A�"�.8���r����>n�5��RE��OȈi
���,⌐��|�ys{��r��"��M����DԝA ���m�P+����/��    �u�����S$�e�P�d�����)��Aį��)�Bv,������V�c��'�Ş�м���[}��d��CnbHظ�9A�i����*���|J��P�(l5 t�zH�$����`�:v�##����z3}��pHcc��=
��]'�]�%�M��ߊ�"�� �䜮Nl�5Ũ�U�]�4�������)�D����מ'�fΦ�q�H]!�Z�K��F�M%����e�B��'�����M��C�'�,�|��w[J+���CtI5�}������QJ"0�'�ZjK�t6��w�� ���I�ܟ����O�x�$Ct��gy8������J�#�:�� f^�G׍!,]B�F�cׄ�RwS���5*-�.��&c�sH(?O\6<U��*�����C�]��J�Jr9�u��r.���v��D���­	�5,�C�ou�Q�P����-��l�0�<L6��'�1���QBf��2^.'�;�a3X$��O�$��NȮw�W���m����w��`��H�~F���,��|�r��}�X��J�˓�Oy�Z�g�*HJXB#��_"�E䂴H N����c�_��*�_Mm �	"��O��%����7������3��[������pVp��Ďi�Cn��j��J6F�cOY���k���@�
�ѕ����a�o�_�~�O7ӮAGD�;�Z/7�#�١uLѿɋ����-�ӴR����(GY� �]Ew��^퀾0S�u��\��ԍH�T{�c�Y�������ϋ[}	~j�
�m�� ��ѽ��pZ+a;�a�a�X�6B��j��z"x�b�͎Z�BI��7�3'����ٛ������b�����\�5�vT
����.�9����@ѥ�tN�²a/C}�I��)��}S*"��\�!��'\�yS4���e�i�W��r���a��Re�u(j�ʛ��o�b��:_�|�v���"��������W�z���g��rN�N����G�ҫ�]�G�2�y}��x����mܗ�����ql�E��M�A��6�H�|>#B�
�@1�s���{�m�mqY�b��b� �LHU;Ŵ��W(�{��%* ~ufbT�p��D�Y����r�2"�q	����A�RT�F�fT�*�	V:B�v�D�Dw���dq�݌��s#������Tt0�ً�2ߥǸ[4�aE���PZ�yl��[�g���gF��@�
h�ml	�������ȴvKo��F	��n��7��N��J{"�
Ud�2dR�$�%@�t�)V��4%��iƃ�V��k�YV�X@��G҆5���m��E�O�/٠mp�p[��ul�e'Km$��02
h�Mn,&NY%	/�!���m�r��S#���n�@��"�W�L*;^%�:��
K"-ήU TF���=~�?M	<{���+�0&p{�Hx;*͊��1V��8��s)ee�]���Ǉ^+dﰈl9!���-J���.�4�a嗪T ���ͤ��">��a
�*�f�;�ȘdJ�ruUF!y��D/9UV'Y0��z�eb;.��l�L�LXŮߢ"3B��"O&/yp��)�^	���D��D�s����/���f5�;g�g��QJX<�,�W��D@��įb�9TB� g����D
��Mm-��^�wεHm���~�˽/�	&�(|������ԣ'!���_@m�:�����p��6Z�CX	D���s/ٝj�a*�A�8zU�A���;�7̈��Vr�D:nP��ix�6d�"fF����
�zQc�lVx�kܿ>��'��K]�����͖(�l��v�1�O��l�y���dP�����X9�,�`�u�P?r#SF�F�fO����ʭX�N�%�D.��o�n�����W�,E,��R�NNҰ;��(�v�v�&��_"9���	=�L����u#Y�x�M_6Ƈ��t$�FTW1mW�6�¯$�H]p�t�'ɡ�&���ϡ�׾O_�ĉ<*\C3��m_�pV`1����\\۔Q4)u�x4���"�T��Y2�&���VAƃ�Wj�*�q�D��#����a��IAσ�1v���~ u$�,(lB�W}�c*FK�֒��d����nz"��w�IsO�9�p��2,��p#��x�q	�^cE��;���A�%����)�rx���!��-,>R�@�6����Y�V���Q0 H���G�4����;�R�3sV�`�Y��������Ƭ�Fl:�y!��H�̱����;�|�r��'�I��|Ck�ݏ!�V���~S� e����Ч?��أbl�g4@z#�#ѠZ����
�t�ޡtW��vF��.X �hz���y�)�;�H	�@��*6�a9��xP������&�J�e�Y�Mn
v��{'���~�5��	�x���6r��=]o6�Y+t�D?�J'A��}w�u9�>ΊW	t��f�4m���hg���B�V���~�1I��8������'���>MVE!Ě	P�m� �۵��)�c$�=���uz=K+�hdBJi�ծ
�6�01�8&[v~�
r�q6��*QCp|>K�����d����f9�>�ah�U���K%�#�kǑ��]B5�4�6��Ԝ[t�
嘠Z�Q*tU���s�Ʌ�T\��z<�,*�+lv0*�4����ptzX��	�Z�s���ڌ���]߅���F�^st��9O�d�K�����4��V"K˯�U&�~���*#���θɕt�����t�u����ipjo��A2�́�>@��w�M[�	�(`��#|���H=Y�������(�ާɬ��c��R :W�1X!C�qFX�j�M;��z�P��Z��:��%!�	���GA�\b2w�{�0s�6{W�NW�6��o�Fxh��͉����(&�A���	�4M5T��ʋevT�þ�1�D4.�u����$AU����wcBi6ˎ�T�7�t䉜���x��މ�Չ�������20'�A��ю}��K4�X�z����o���h���Юy�F(p����\��#M��G�n�t�}�c�L����O�?V������ו�C�Q���)Q��Kj� �].�㹢&�K�7��x��y���y��E�QW2�ӂ��G�y3H�2���>9Mk������)��M��@  �q.��_��p䗋vh�
�:p�f>%�M����~�9�A���}&e�D�ϐ���r�t�i@�H������@����������Ӈ>�$ٚ��<�O�% 聇}�^kԶ�r�(m2�s��v%T�%���f��4�.Lm�}�w�X���.�s|�(�^G�;�Hkyh�Z-���G��y(�2��al�,�;y�\wȒ�^��V�D�W

dp�H��%��8�b�\���5��ƃ�`˲�a:�󕥮5i���!�3h~n��z�BB���],=���
/3&��ؿ\vW�Uôû;3�*J	��#���0՟O�#�C���e�B~���M���D>j�d�װ�l�&��#���}�BR��9���6�TW��1��ד"u=�����f�Q�%�n���m3&���G��#�Y�u:�:��z��H�����:ry.N
2��f�����W^�R��<1xL�4=/�E�U��VpI*��f�j�a�m�Gn����6&�ZaL�U��߳��w�~/\881$�gޏ��#G�[�l���\|d�=���Q��C��+L��	Q}��·�L�#>w�GzfmN��7��������,j��᷊48��Ż������s���|�i8�@���<p��t��_L��u��d5��b<_�����j�g���d0_�~��?�C_'d�覧� l��7�.���6��6�ќ��E6l��tJq��@���J��#�K#]��mt��Q�� ��{d	[(�iAIB�d0�ſH )>�$)Ɋ �_L'Dщ��@�T�8Q�k1� O�E�Ts �-�X�#S��gH=��$_%��*e �����<���ޕdvj(U�B���R��br5��Ck>ڏ�z�}�v��t�l�����0�op<�+XPͣ���M����+����|���_��    �Z��޿�ƴi��t�X�ͦ4��Ɩo	g�@oT��D@?g��]��T�]�a~�	���F��`�X'�W�b�e�����JK�q��0䲲�b��Fۑ^ȏ[B��H�2��ؒL��Ӳ�L<C�p�����碴Ny ��(��^�aµ'?��q����\��e��F�$=~q�T��kE��FCĺ��q2c�`�d��5@���4�.ZN�Ķu���9�<j�cFn���Ṫ�h1��iF����4:�����b�o���$��v%���x�֪�b:[�W5��
SɌ��ʾ�m�~���7^�(��@J����*1X����v����Y$��ܘ��LF1]���u���G��a��]�ũ�K�c��!@�棭�v]�o���A_�f����]	|u�8���E 8\�j:@�r��00���0vq����� �_(@Z��ra�h�¦��X{��Ӎ���`��W	�;�l�[��j=gI��/��5��)_�A�r�e��v{n��Jp��-eD�N��q��ȇB�Xs��������0����������r��O��H��2g�O'1�&H��2a�J���r�y�6٧*�v#�u�L��U�
���`>�,0O�Q6���U6J<��T�F���k#.קbh'/$�w��b7u��l��ݍ��f�~����|>]�7�d=Y�^�%�߿�ʶy�h��l�^��f��<�`~9��Tk�~)B�<SL��y�zP�1�ˈ�q���0lp�_��Q$���3�u���3��2�ЕR!E�|r$Ycƞ�L��u�.�d�cR���Q�6��3��8Q���![�N6��� �@ڙ���հ�Nݬ=�l�h�ڪ+Ok׉��HAt9t�)9n����5��|��'
��h��M�6�Nm-�Ymv�흹�+��Q�����Zd����Kᥫ�8�k��b|7[f����?M��l���4Ȫ�5�Qu��UA3rIJ�)V=�02p�@9�3��@�Ѵ�:�!	(b=�O��̇�\_t� �0�PΗ���e���j����?>*�؞9<�5�Y�\����¬'����٫H���f����,�j:1'{6�����嘤X���9-A\l�PRW��@��ί��|�n�t��j��b'FJl�m$zʗ�.�R��hAf�R��%ŊU�eqR���k�J>�`�^0>88�GgW#��J��wI�E��t�0�|pTe������a�Z?�=^�Ԏ�B�scA�ɣ��~�+�H*��@!`B��T�}������qZ�M`9�,�*��XL�f0�Y�85�5�>���u�:����-?�����`�Xf��t�aU��l�B�D��`,��]���)waZ3�1�jV�]�Y8��D�-�^�(t�4M��'�u
�P����.��bhWי/���a`[b0YkM��JW[��ܤCR��+fi�1aG���l�cN�>%ڞ m�h�U���bhΤBT��'B�v$�Os���d��n�r�����}5��ц�13�,'�A�"���:]�O�{`�KeUU�4	>�R�,%
�����F{�ȿ��������?��Fi-�Q�?N`���c��G�6�Z�m�JL�8�v�п�,�`��\�I�h�ӳ�H�Á�pMY�)K"n��'���M&��w��l���~&Vx�E�g|���5��9KGb�[�"���=�k����{"gV;��X���o8;���0�<8fi��T 򐑤Ň����o�K�W��	0e�7(Tnӝ���[E� $��S��j�ZYrr���ͧ�9w�|��#H�t���qar���,ꫝ�	�{��,L����N���<���dn��l{DIEcI���'<2n gZ�4����p<_�i%�i�%�D?���>{ŵ|K�i~${�4��\��(YYT�� ����Nl(�V�3�v#�Xw�����"3��P��K��)\���f1���U�F٫Pf��Uj�t�R M��%٧�'<��˙��q����|>�l2N�a�}W=��}�}�-�}�a��|�d�.,�Z���S�T�	F06�����i��n���	���l�ڭP/���r?zx3�������^�Fѵ������,f9�n^<��5���}�?�k���CK�f -4�;T����u�����e��P����z]=��'sfs5��r!��_c�7C���Dr�[�Ȟ��9y͖�L�)�:��qM�$h�Vt��tI�X�Iz�޷uЁKyQ�6�R��C+�*g�	ymlQ�Vy�K7�-UqL���N�q�M�S�B�ߊ� ��V�?iɑdL���+�\�ias��� �J}\YgC�<�P�F��9���D�u�%�T��\�Ɍ�d>ߨ�.0y��Ug1�`��X��C��g�hL��O�NIs�˸�6â�	�u)�'�ݢ�H�#�8�h�JBՍ�Q���x3Y�\�Ww�Ș�"�@��o�y��/�'_���/SO�#��{f�����%�F
�s}���u�\;&�0;��y���e�y�$�����HL4׵R@(�H�k�Ϻ�"��bÐ�s��7x7fl�z�|�fa�Znw	�א��3�<}ǫ"�|.;5�Å��Zy|vS����,i��]%z�A?F"B�#]�+�PRx�^��l�qq��W��,�Yjh�I	�bP:I��s�'�c��p5
�>N�a����y�{�E
Q�(�+�z_�}�>1�bm���g��\�&�ٝxʳ)�I�
p���%�>�=�����qB)�p�ͱ�����a� �/h�e�9)`$B�
�lSA��e���������z�<@\�J�@�*�{�=�D��m��2c�0f���a�Y7n��Β����UUp�t��J톁����{v:/p����r<��>�f��uJ�KБ!F��Ł f(�oؑ�� �2Q_x铕ʥ�q)�P�`��TJi�	J�
/�K�\����z�I��kv��v��5���s��?ђϦ�ՔK>U+K>�㎢����	C��~{EE�}a�i��f|3p��� ��,��VҗXS1{E2���uL�PslQP��G�Q�i�|�hlH���U�@*�H`�b�g{�����e8:2��Qk�X�záX~�(L�_�C� }�ώ8htC��3#I��)��墍���Y*?N0B��@(JE�W�����z���(�q�vw&)�4�l��ㆇh;B��{�����K��0v��!M�T��5"r�)� �
T�5*M��K�4�Ψa�� ��t�ëI��Fɳ΋t BX��Gˀ)��^��c��iz;�)j�+T�ř�6^��
��L �̛X��C�&���-�C���v�w�t��wZx=x4i�.�&�u�r���6v�g31���r���/8e+"7������,�)r,�q^\bi�(�D�>�@�2g4̚O\��m�P�\�U�d'��+g�&v�)0w��"��c4�j,��9x����g��fu�X���ſ���L��d�+,�#xyu>�ym�e��8$P�3<r��6��;��?��Q�z��8�,���(�J㦿dM��� �:i��@bQCddx)�$�Ց�J�՝G�ץ-�UH�=Y)��-���}nlP:�"6���3��^���b�M���M������ᾆU�0I�)r��[+���t(���?� �A����L����:8&-�I9O�W���l�g �x�8&m�N��7�I6����As�/Շ�Y�FY.�k��xc�9��F%4L1���m00��ο�3$�ӫ$��^��R���3��>�O�f���ٮz��~.��{�e#~���
�- T�ű9�B�a��aBeū�\����B������ 8 p�c��]���؄�l�r�ХP�b�ɵlO�J��3˒t�%�ŀWO2��Y�R}f��.�
&��X�D��UfM�mu^8,�*o�s����f:�[,�e����9�!��a���e�n0fD(%��cctq�5;����L�:�� ���{�D�O��:���W�E)Z���L�o�nkm��ؼP��986�دmz���LySt>���Q���0��Ph'�T�`�<    ꄄQb@��+;ֈ)M�@����3����ƞDYQG(9�Y�M1o�u�������Ih�ʛ���U{�3�0r�,���wkd���;�'��T+��4ǆB��D��N�(`�&�89���O�ޜ��4 b�HăoHZ����ЋZ1��Ƨؔ{�$��(뮊�:呉����'�:��oq&ŷ��1�������5���0��x�Q�(0�
�g� g"G�q��X$�C���`�U����:!��M# �pk�<��
�&��XO����b5���7mp��*�*AMu����$Rm��,Y�E�dР-����gdC�K��#�����+nyM/����Bf�X��x:w�߈��w>��
�<�sR��u�lSIB�����T�m���T���rGxN��~p�Y��P
�I� L4�޵�����<_N�����'���m��+k ��D�t�K@K\�O�/L��W��)���zh�NC�!�q������B5�6Xg�f��!厚Fۡ� ^�L�ЭWp�]����2&gF���4I�1�L�\�F��[��c-��֫�O���C��[dݭ�(&�	��v���0�:�T#�Ɔ�ZL��O��;P��Q�-�w?�(b�٥���΢>}��p_�� ���h���Fn)���2�yL����?�ή�C>';q�5O�ٍ��k�M�gV���:�����y9;���,�~w:�sʂ��Rj�%l�;� )g���X��$�mˎ��B\�<Ԃ!�p5.��8�2�L�ƃ��4�0I҄�P V*�`*�H!Au��O)VY7�2�5��t���$c�Ƃ)����}'�T��y��h'�g���6�"T*��t�D�ف��%F!0���*.ؾ/.Ja�6��ZB*��8�n<�+�{m�K���X�D���*!���m]���*9{iD1�ܿ"�1_[Ip����w�c����#��<!ێ�Dgg�R��T��M���<q�i�앬'w�W;/��*�Z�JM��(����g�ϒ� ��&�0��Õ�j�
���<�p�-�1��zִa�*�-=���]��$�;�L诿�}�믿��K�|P f	Ӓ��^BWl���4�.q`��6�Ί���Bϙ�K57����Tw]���mA䭽���ro6XZ�i��ҽ4�[,ہy�S���ʟa�Zu�Q�9=��2��Ɖ���B���rIl٤�����)�h����_�m[s����j1���z�Y�-���9A`���p��D�R;�wW���ඈ��O;�޴��1�]�U�%fz�oB9��]��=M�t;�r���R���_���#��ч���N2]�g���n9�ڄWOkI�y�%�7��T�%2,K`�z_Y�&��N�K�f��>3�}�c(���B
l�u\�����V�R豜.5z��m��[��5���1�Y˿��K`�����.)X�s��Rq�O��SY%�(u^�$��Y�ȸ�a(Š|����tcd�\-�S�i�$����+�KPN�=�rXQ����P�fNd��)��+�$u�tQ����>m%��=t���<"�.���J��\H��4`�)��@�j��v�F:pad��|C���: _^�I��u~��bS�D�%g5�3����@�I/�YC�p����8	j�f�0B"0���1o�l�\P:)�IF�mh�ҺY��-H3������6��z��#lB)�o�M9�D�u��(!�t�ak�w�_�=��v̭l��3MF*���Xh��WE�Ɩ�/��o��E��ĺ}��:�]�G~�R����_��dx��b��q:���Q�pu��]��l�`�b���Vw �!���B�v��8^U%т����/�v��������,�/���*e:٬Ƭ-��X��|�n�Y��!F&�4��9�[��©����W�.�>Ę���dݚ0}�$t�s�)4o�������-�:�����@�t���?�z�Di��@��GV�U-����ƒ� ��R\'=b��ɭ%V����X��j���K4�:�%���D(�7�Փap��dZA[���e�v@'�(]��Ċ�&_r��I�칺^6�J6+���8NLw�����M$zO��ɡ͋I��X��ew��FS�I��0��U�����ܔ?������?�а�����V��{�r��UiE�e��>F�<�y�{���tȞ'_A�~�D��G�B�6JP��0��0�f����$V�tܢ]v?��G�T&S���؟�*N�}o��C8�����*-	� #��w���p��<��%:�!�ؖ�f',$up���]Bd�f��	m�\#x-47�ԘJ�T��i?�a�L�3�(�a�\+!���%����m�[�����>���B6��@ۚT�ұC�`oC�
bl�����&F���Q���Fɑ^�)1%u}��JI1�����d#�u��C���ͫ�Ti�TE�H� _$$>k�o��vQ�{�[7�Ѷ;�rB����a���j��mݯ�gD~��֔�g��v3vğ0:�My�4pE�ɳu�h;u�n�i`!��G���/��p� d�J;P��+o(��SA����+o~��,��c>Yn�w�� 9��Mo>��3�/u�p��L�K ,�%�rM�d��8`�y�����OBB�tj`����UC��N~��1(�O,[
�e�G[�A�Pݓ�=�R��f��rѓQ�P,�B�HHP�4��FT�ki�V)|�^� �>&%���2Q
'mpN �Q^���q*Q��(�9-[!:%a�j׈.Q'�~"��Uo1�!�i'�Q	G_��2.����ӃE������>^z-�ĐY"5��}��\�0!��7�a�G�RZ��fO�?���ԉv��pŌr��.��E�E�{��e���� �r����n#~�O�U�3A���Y�����9Ä�d/{@:�T�E�rP;��m7�zRԈ��RC#J���@@��?7���M6K��7Sq痃��2؃)&�D�L�ٴ��ܴn*5wS�Z����8D���s �/#��(xg��_���b��'����Ay��"�UO< ��0���>>�5PC#���H�h2�h����ֆ�lcb��C��s'[q{�S�0o;ō(�V�;��x���- �^e2�Ԧo�ܺ4Tq���a]I�#��y��B�}��ַM<},�3w-4�&jEX+���l�Q��zι+ಲ*j=!�_�#�X}�:�ֆP/���Q"��+ޟ9z�wW�4��q�uˋ�g�8ρ���h�uiH`\�Q1s�����_��zf�V������g�	��\]��?��[o�o~��,�rd��W|����]W��#"���
�KCNݷ�ߣ�"PVͦT�S�ցe`e����빗��}���洗��r���ҏd�@�T5?�jݬ�3Sp���n���\�^U=f�:d��7W�<;�	�Q�0M��rͶ_���o�G*��N
���Ȉ�Zo',�2~�5��t���a5t�k�:�6�hE�1��V��bo��"t�>Y�H�+��m�5v-��XbXa7�:T�C���f�в���lz'����=�Ʒ�ײ���*��c��%���Ю��&M��(Yܞ4�x= �{�q�2:���"*V+PFq0�nN��v%�������WF0��ʜ��a֍k�"Sb�Z�`��` KX8����u�j*��N6r�����K�t���kq#�S��AhE�A
h�b[@�����|ƭ��	���:�aa��w1=��{����C��P�6ط�<^U�£ҡ�<|�J���4���l��̪����m�������������j:X�ڜ$���/��r��٪���@*�EV��>=iii1�K�&��e��i}R�#;wD��'WC�����d>�[��eo5>���w�^0�������x�!�)���땻��
Ӎ�XY�����e]�$~�>��X������3�-Av������ӹ��*.�Y�F6ܛ0�"׬W�Q�;l&����\�{5l~�    ��I�X��x�?Gٗ}�����ԦB{� �3��~QOC`��"K��i�0��(�M����d��!�і�0�����8J��Ás��C��[��0�m��ᚎ��.V���n�l�D�zU���!;f�~���c��Lg�Ӷ*$'O�ّ�<��T�l6]�x��H�����oz��0�?l��P��J����|�61^O����j >��%��ʹn	��Q��E�V�R������'��<24A=��U���c����ʠ���IX6�Z���j�'筄�!�u��'Tuh T���Z�Ю1:`��Z��2C��-����CA,)�|�O��8�������$��֒�Z���d��*[<�;>y���o��j �{��wrr��O�Ћ�.A�������z����g�a6�DV���=��[��,矌�W)*��ܠx�-Y�-W�G��sA)�_*��(��4c�U��T@�����8�lt$S�y��Qv���3�fS�;p��Z���=��ta`z8Օ��j���0]��y"�6TS�� ��#>w��LpC�]+�<ԙ���!`rHd��Ժd_Mo�鯫��<��#�A�9���a�����&:��=LṚ�tm�ѺF��fFO�Y,ǫ;�{���L�9�~ό4��Ku��d����N���gl���$=5�4}������F�p���݃��rH��C�?�C�7�d�4� ����;>J�c�mH-�1ㆸ�0�$�FN= ��Oط&��h���%�(R /������ջ���n�mG��2\D��0�-)��$����H�U��� ���4�� �ȗ]�����4-�w�3�w��ѩ\�YS�&@vZ��/����!����X1@�!W��k�\á*Z[�mZxt�W�bM��t�Yp{D(���6 ��l]Wa��q;D$��/H��괊�@��h� ��쌄<];�3��[N+qz�������XY��]ϵ&�qi�F���$~�� �ڊ$ၵG|#kP�.�J�".����6|���N��Wqr������3�_1�!��Z��ϥ���a���W)�'�������]UH���ƫ��z2���d��c����p���$�uϯ;��$��G{{P�[��_S�.\�#�j���ʳ���,�(�]'���Z���<��5�N�<Gn����:n9��f�����Dx��v�b���B�9�Q�S���$��	�\j(��*�Xm�67g6_������1���0�A:��Q9j�O��J����p�^}�	ik�f
��<�	ل����E)2���J�+����G䈝�~�(�_�07	��1��N�v�@�嚢^��N[��ie1uP�<�\�X~�{�t�깃�R��L��̺�rhM.�p${Ȉ�ߠ,�:z�@ӂ�G2�ǣ��7����*�?�1�(ڢ��:�fJ{i�Q���?!���� S`7�ֳ�b:�N�O}���'Q�r�P���S��R�X�6�F�b�`@�g�l��z�}��+�i���@I@5���F�J(3�R.w^;C�Dyx�Q�W`el����ٵ1�	M���um���]=��9>Vu����U����8���)BZ�C�L:ƧA�;{��������.�����䷬�˗]`)��f�!��Zo ccY��� W����ۿ�SE
*�~���td?�.� &�}Գ���-�d9�V֯@˵i����=q�Ά���z��
zb���wZ�آlz)��-������$6y�ݤ2E��������Y����L�,:��l�"����)���x�t���m�����/E|I�;@ƶ�*�������Iږ���V��+�z�����dڠ�4pBTù�08Z�&����V�n��u2�,���ܹ��� Ί��r�W3tp}�@�v*�z!��w튻��1<�ɧ�fg�`m�S���D�!�8l�j2�˒�|�(_:����w���x8�'bm�����?�X�&����88�D����d�����`1�)�����"��bsC��k�i;���4�Tm3k��> � r��5qNRf���G��g���$���]�9N�d�����>�_b@qJ���F뼲Q�_��'�ϱ�A�s~Ct���67��b7�l)��f�]���S�Ð��GWV��Ũ����݂Й�hr�i�|E�悳B.�䋪�����I�����xՆ�{v�P$���f(WG�%f��&�{���c�%�b����	ާ�u�c��r a� �׽6 ~RU�2�V2���N�l��~:|��=T-EinDL�v�Gҏ�ۍ��0��ר<����:ed92�1,-�D�W���to���d�uq���B��R1R���E�cTs"a��-:�'079�;�� ��-��H8.�ٷf�p��9QJĕr�af��+H�P;s�V�f��I�9��t���6��_���w����'O���F&N�c��0]l$�^�
�,�]`^�6�nyVZ�K��� :�X�\]{5e��(I����?
}���@w�GZs��{8"%~W���h�n1hN��z�{qR�$c�K�#ʆ ]��������
�1��Κ��/`���"C�M����M�'���a��Y�"�.���[+T�cI�Kl/&���|Dr]��BE�����$�N���ߤ�[�?��
e��༐�!	 �e���C�B��2�q��#���^��%��+�_	s�K>�']۵���:�o �BcB�R�`fS������h����4W2A�se,d���g��?F��F������Z�ް�q�\�B��d\��|u�^֫�'�1��RY+�eǮq��X�<����[T��~��ؘZa����2��;5T��G�R]�4��:���"��&����L��/!)�#P���ʭ�v-^;�7�]�^�~�\L�FH�끤~�YE�w���B!Ʌ�F�����	��z��`�Ǹ��K{͟��/�4��fv�b�H�&�z���N9�W�(��^Sy�[t��<�ʱC)��a�#�xg���A�J�E�&G��:�UG��.�T)�2�Ȅi��$Y?�O�:U�_���l�|���z["F*��=�V���Hu���QA3�e���QLd�w�KVo��(%5�;�����!|:�U���4�*L�m͠�#��b6V,|��U�Yd7ܝ8c��� �F���=֔�|�la�2�U�v�f2��sq5փ�t�NJ*M*W`���Ǔ�3J��)�UQ`B.�>|эpe��m0�}O@����c�֝�v�(�����*��ЎH)A3��ē�XmEʭ$���6���7�qă��t1���{�q�3�j�N�cLd-��ל`�&���a2O?���0F�*z��(���&��ڛ�1��#����zsC>�Fo	�8鶛�e̮K���<��Ȟ �zI���{-���8�"mJ����s��0ۢݹ����#�"Q�-�Z���i���Bd��J�]�qy���;#���G7 ^�L��_��,Cl{�=�y=i%m[=�<f&0���G
�H�麯3�	kM�ᠡF'H�eݣ���;�raz):lV�%�:��vh�0�nu(M�`_i�����f)�����B �I]�YLe&�{F\;%"ڲ��i�M�)o�t�? �Wd4��QB�!�~�	L��7���e6��	�����v�� ��6I����5f��®�b�sK�k`�>H���]�J�qA��x�p@Rf�~���+]��WF�u%OxoF�މ���wa�_H��t3��=S��yST�i۳!���+GK` � �ӧ
V&DB>%N��H���^���)�S-xs�O!竱�m_�g���n�lf��Q{����N$��ɄѤ�q�(��.|��`pб��6�O�Lhmt��`�.��z�����pI}�����d�T��t"A�f<w5y雼�*���Cl�xe�P�ǹB��n(�N�a� w!���xyFm���6��?��5hֈb�H��m@��1Eq�hw���)�%�ڟX26�7�x�o�O���+�C�k��A�Qi�ߺd�FN�    �K}tqMv,�<ۍI�b�<6;��V6ɮ���24�-7&C���n3��W����u%)=�~�(��ҧ�/~Iz��@��4�mlJ� R%}B����i�w��?	�q�س���̄���ͯ�4�z�w�>���_����Og�NA�b&�v�O$	�ȱ}",=�ԧ�����02���M�����1���PxM�����J��Pe1eIE%?>��u�I��)@+eӴKَBC~o��ɧ��!���p4����6v9b�eԣ;/��s�5n��
4��ʲ�݉QH�,Ez�R�B�mt0�=��U3G��B򪨫yc�TT2��7$���F�B��N�E��laz�t���9$)(ڌ7{���5*5�a�x �rr�r���wnI�HW�D��ܶE�i��)h�L�C��
	���x�7ٹC�JV�bI��k�g�����8�Rܩ�����s)�6s,���`6��-)�]�!�SY����P����\���+�y�f���tp@:J�^:�G�Ý��Fg.������ǃiB��mި��r���+�f��3�g2�=��,���)|Xy�u�H�c��5�~�m|��b���Q�	1aǳ?��\�u�B���7�y�Ud�gc���a:�h��rWڰ�h�=�!�(k*���b=�ir�6O�wp�ֽ�	lzڹ��2�k�SU��,�xRǒ�����}U�c(?r�׭�W���%�ͯ��ˣX߂�o�a Z%��S�(Q���d3����E_�zlщ3����7||%�4�$Q� 㽷��	|���vƛ�^+1P TQ^�(c��׺2J��d��y��^ϙ�BO�]@�n*����9�w����t�FZ/�/���
���zr��V�{�04���i��67����R�x#ٴ���,��&�0��XY#l8�Ӌ���Y%�ق�p��Q�큫t;
5�l�|&QT?�s�9�&�)-���8s$K�m��0���)��c�D�a+/l*K��C��2�}a�	3�H�@���}�86%��#L��������4�˩B�'82� �{��'���Rt���_�L�B*a];�޴�\��R�ӌ}bo�KAb� ~����K5�E���?It:d�<� ��y�؁����5���O>�M6]M�Gp��LV���ղ��^��ˣn��${w�Æ\$�"�Y�~	妲��ԧ�_�ƻ��[]�P5>㠧��]��VW�+C�-�^�������M���G�[2~ j�8;��n��WSLQt�*�2���=v7Z����3�J۫ԗ&�tF��A;�Cџ�"�Ql'/RY>���Z�uJ[�P�*��~_�����0��Xꮎ�q���Ɓ/;�5̾r�@�%��e#)IE֓U�b��<�u9$HD�$�h�dDUӦ.V/����P<,x��zI1��q�2xP��r��jx�:�ǀ%Oi4lے���+.I��t����{���:ی%���.P5˝�=���������|:]�m����w��X�z�|!�ش���k��5=ClH	�n��y�ۭ�I�i�/�LyC&	G��_g��XE��4|���R�t�~u����2L��Q�t����f��r��#�iB<˰��er�o�ǀ���b������"k�l�W�x��* !Jh���gp�Zc�����
_B��#-�eS�-���d�8�w@�8U.1u����vt�Ǫb�MD@�T]�*l��;Oj��=���(�*��������;��8�113�a��$î�n��V�6�W+�3V��kF"PlrI ·����9AǊZy��P��Z���Pce�+No�w�~�3��n�F�C8w�]G�͛��LJ���꣨O�=��,̆��������z��۬�YO��n����zC[���u�W��]8F����W� 	Q�h-�"]�dmA6L�ŇsC�8/��A3��KIS
������"AГN�0Q�F��3	,��בE�૎�rZ?�=(W���\qQIZ�"tx��/�A�-�=�rP:��i�>�d�)�甓0.!���c}�מ��@!P�%t,��7ө9�#�50�p����/]��8�-W���A�w��@9gs�.���ʉ��V�����91B��a�qvc,?�>�����(\O����$�kؿ�˟�J�P� 9.�?���I��!ÿXO�K=���t!�=XM{G��ćds�[#�:�^ۢ�����*v�v	5���:T���|�p��< �.ԃ�w���; ��5��3�ŽU����!�>����f��(�� ��&���I�r��%�SꞘ�����|)�KX������>�)w�cz���g)p�>�U+�Ჺ���U2�+�E{��f����0��y$D�$`G�`��Q.u�
k���K㼢��Bww�]�;�����|C��ٛu�i��?I@��*q �1�c��ܪ.��7�]�_�)}�1��� ���P*��ؕ��^5��JD�9��4���}������ =�%�B��PJ���ھ?J%�5� �5�b�sK/��oߠ,x���"��¤Tza���3I�lJ���N(<�>�>W��n�?[mD�a��r�;�o>����Jf��,�����<š+-9n��ݰ�ٵd`󍵣�F�s��$ݘI��Wd�ϴ�?�~w'l�����4�g�z�K���RO��NG �V���7��$��3�-���s���C��sby���H�-��c�%��SlC���t����L�ۿ�,��0[���=�.�#'�w��!�d ����f�e�m����!�I��+�='���?���h$�:Cv}Z:K�|/|H��n�!UA���-Cy�=��������dj����t�/�H�5�ݔM����+x��kڝi���Ր��a��Z�'�=�>;�Tv��+��~�B[�����S%��:����k�J�_�M�$�Qt!sw��X���e�M�&���_IJDG�t�<Z��ґM{��g�!�c\ԝ@�A�!t�(+��"��8)�5�t�!���'W=�{�̟�D�Vӹ��F��dj�L|�kk��*b�����EI�y+`�l*1����:5��;����Q�MeC�rL_����*�*~��0G����8�m ]<��k�sC&d�t���ܬ��f�Q묍�ɵM�V��b`J9���:jG�f�fu��;���4s|�
ٮ�i;��X�L�[jHon<m��߫�?��xm�H�`��@~C\d~BW�*ǐG>Zs�zA,��"A��ܮ��1�v����SM$��olG
��f�y�J�yf�$-��+M����z�p��I%:���t��ނ��_��꥜�TU��~X݆J_2�� Ō�η��F%��3���C� ����jA��d�\L��'.X�����q�:Sו)�Z�`_f��!�j��;>C����VV��'��芝�5	l��m)hc.s���'4¬��Ј�a2kj˥Ӥb�~�w5֛� ɠ;��ܱ����~U�T�=��q���"0���XT�|�\fOp'�xZj� N�>�= �g�i��6�\qX��d#�=c����ZBaC�i7�ܢ:h�;5�=��G��'c��<c�?�L�i���)u�]W��_�K��WL�?�������|�j�j6�MV������I�6��U�xg�J��2�߶��*2�TY�R�v��%gS�U��3�My@b=B���®��A ����)~UrJ9
=�b�i������u�U�c0�����7�Y/czl����N�2�:M���^ /+���}�GM���v�P�ǌ{�M�xGq��8��sQ�#\X�鲉8A惎=�, f�g)���-t��s�;WM�m[ͻ�$�B�B-r�H�oR=�����)����#2��҇���Y���w71C{Xڿ��%(TE��_qM�ދ� ��(qJ�3�0���Mw��of))��(q�&z�W+
�u	�1F�{
UU��.��qO�����K{h�� +ߵ|�Oa�{�'���Ԕgl�{ˎI~f���]�٭l����ծ���Aj�䪑U���dB �   �*Ts�(O��qߡ�,��+�y���RF�����څ�J��u�(�ߜ<��A2�>W�]i�(k(�Y#�#����e,Ǐ{�:K���-Ohޠ�/N\�N<�m�k��C<�!4���B�i�k5�Jq�"���Q�+޽d��w��.Jٖ�T�N��{]�J��PiC@`c����;�؟a�]5z]}������`o�-ɃI�GY���F5�         `  x��X�n�8]�_�]7mG�L�&0�AŠFbiPT0�j~cv�/�'�%sHY��Xl�B��=$��оwI^�/�"+��mC�Ț�}-�/�$w��;.��خ�k��7oK�׬�8��K�dQ�E��~������SA��^�3i��n°���D �ך�\���Q�]D��"2Vf�,��B�J��K�O��XN�f_�x!�.yx�J�O䶢�m�wZ�RъY�/��/TAŎU珷�f�e8q�\$��3�D��U�z��p���S)N�#�z/L.Ҟ��7��ixMɃB��?� ��Y�N�m;\1SQ����Ƚ[��O�s�'t7-2����	�YF�4=9T�O�����6r���/gɺ��P!e��X�HRK���d;n��&��f�tL��34/pr-�7�ʥ`�KU��R�H���s�k�s�ȻV �;/�Z��&e�h�+�p�I<61WJ!����󯋗Y�	�#���"=o1*�y�lj���G�(��UR�ν֝�;��&��� ����m#+&m⥩L���5�-Ec�kV�9�ϲ,#۸�����2d��u��!Qӂ�@�B�h�up��)W4��L��݁�8��&9�嘇�-[��Z��)��S��r�g�J�o�To\�L���EiU��5|3�嗽�T:�*�]a
0���e;�$@6ex��]��st�\|��|�V��Y3��	�]�{��o��B1�B��J�0�������d�3oKJ�d��۱d�´�.�~�0�Ki���o�l�}0�	J�u����,�0N>a�c0-&qbl�B;�c��d�<�ᰕ���0���_K߁�~�:w��d�DN��Xر>�:b��1�H�+���t���������ܵ%S�# /�x���Hm�+�hy��X�{mf�S+�2*ɼ�B�s�RH(�V3��:�j�n1'��i��� ]�2J��법���f��뷒"��;F�P>h�K��i��V� 	,	�'-&܊B{u��X������7��Pz�}嚨q�T��������YI]S<^zc�
���b6�&�5i�:��{Z������s_�b�w���^�و�~���N�obj�pF������k���f�'��k��F'�Hd�����/
n����d�$�vA��[����(�! Ix�t	F,�a&��X�y���	sa�p��+>�'pnJ�p�%9�o���e��h*fbU.�d�O���]٩x���_wNuL�(�ux)��nl�"�K�#���+�6�{cԏQ���>���J��S7�4�y�>�h�pG�8f�����|}Xm ,�}8ں6}{؇��ȏ��W���<c�O��w��07�Y�`dq%���c�Y8����)UMq%����v���nqӊ�u���ȴk宅�	���=��D��G;��p=��C�65s�'����t��侠j�՘�����w��cjp�.����6�"5��
�R��q���^��ˣth�#�r �����`ѥ��D���y22��"�rǔkD�� ��"t�u-�
4T�kŉ[���\� )�\��Q���l�~T:]�o�~��<��)��ؚ���wN����;���ϋ��?��F     