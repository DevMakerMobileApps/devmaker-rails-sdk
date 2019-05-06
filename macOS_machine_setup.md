Instalação de uma maquina Ruby:
- Ter certeza que todas as atualizações do sistema estão instaladas
- Instalar o xcode dev tools `Xcode-select —install`
- Instalar o brew: https://docs.brew.sh/Installation
- Instalar o rbenv: https://github.com/rbenv/rbenv#installation 
    - Rbenv init + atualizar o bash_profile
    - Rbenv install -l
    - Rbenv install X.X.X
    - Rbenv global X.X.X
- Instalar o nvm: https://github.com/nvm-sh/nvm
    - Nvm ls-remote
    - Nvm install X.X.X
    - Nvm alias default X.X.X
- Instalar o PostgreSQL
    - Brew install postgresql
        - To have launchd start postgresql now and restart at login:
        -   brew services start postgresql
        - Or, if you don't want/need a background service you can just run:
        -   pg_ctl -D /usr/local/var/postgres start
        - alias pg="pg_ctl -D /usr/local/var/postgres" ???
        - 


Sugestão:
- Alfred https://www.alfredapp.com
- Spectaleapp https://www.spectacleapp.com
- iterm2: https://www.iterm2.com
- bash_it https://github.com/Bash-it/bash-it 



