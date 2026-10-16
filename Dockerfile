# Overleaf Extended Community Edition (CE+, projeto yu-i-i/overleaf-cep) com os
# pacotes LaTeX mais usados em TCCs já instalados.
# O CE+ adiciona comentários, track changes, papel de revisor, Git, GitHub sync etc.
# Os pacotes ficam "embutidos" na imagem: não é preciso rodar tlmgr depois do deploy.
# A tag 6.3.0-ext-v5.1 corresponde ao Overleaf 6.3.0 oficial (mesma versão de antes).
FROM overleafcep/sharelatex:6.3.0-ext-v5.1

# Coleções do TeX Live a instalar (cobrem a grande maioria dos trabalhos acadêmicos
# brasileiros, incluindo TeX Gyre, português e abnTeX2).
ARG TL_COLLECTIONS="collection-latexrecommended collection-latexextra collection-fontsrecommended collection-langportuguese collection-publishers collection-bibtexextra collection-mathscience"

# Opcional: repositório do TeX Live. Deixe vazio para usar o padrão.
# Quando sair um TeX Live de um ano mais novo que o da imagem, o build vai falhar
# no "tlmgr update --self"; aí basta apontar para o arquivo histórico do ano da imagem, ex.:
# https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2026/tlnet-final
ARG TL_REPOSITORY=""

RUN set -eux; \
    if [ -n "$TL_REPOSITORY" ]; then tlmgr option repository "$TL_REPOSITORY"; fi; \
    tlmgr option docfiles 0; \
    tlmgr option srcfiles 0; \
    tlmgr option autobackup 0; \
    tlmgr update --self; \
    tlmgr install $TL_COLLECTIONS; \
    rm -rf /tmp/*
