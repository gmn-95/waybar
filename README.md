# Waybar + Hyprland

Minha configuração da [Waybar](https://github.com/Alexays/Waybar) para o
Hyprland. Ela usa a paleta **Catppuccin Mocha**, grupos arredondados e ícones de
aplicações nos espaços de trabalho.

## Recursos

- espaços de trabalho do Hyprland com indicador da aplicação aberta;
- relógio, calendário e estado das notificações no centro;
- uso de CPU, GPU, memória, temperaturas, áudio, rede e Bluetooth;
- ações por clique para calendário, áudio, rede, Bluetooth, notificações e
  desligamento;
- indicadores de GPU e temperatura que exibem `--` caso a métrica não esteja
  disponível, sem interromper a barra.

## Dependências

A configuração principal requer:

- [Waybar](https://github.com/Alexays/Waybar) com suporte a Hyprland;
- Hyprland;
- **JetBrainsMono Nerd Font** para os ícones;
- `lm_sensors`, para a temperatura da CPU;
- `nvidia-smi`, apenas para uso e temperatura de GPU NVIDIA;
- [SwayNotificationCenter](https://github.com/ErikReider/SwayNotificationCenter),
  para o indicador de notificações.

Os programas chamados pelos módulos ao clicar são `gnome-calendar`,
`pavucontrol`, `gnome-control-center`, `blueman-manager` e `wlogout`. Instale-os
ou substitua os comandos em `config.jsonc` pelas alternativas do seu ambiente.

No Arch Linux:

```sh
sudo pacman -S waybar lm_sensors ttf-jetbrains-mono-nerd \
  swaync pavucontrol gnome-calendar gnome-control-center blueman wlogout
```

## Instalação

Esta configuração usa scripts e caminhos em `~/.config/waybar`. Faça backup de
uma instalação existente antes de clonar o repositório:

```sh
mv ~/.config/waybar ~/.config/waybar.backup
git clone https://github.com/gmn-95/waybar.git ~/.config/waybar
```

No seu `hyprland.conf`, inicie a barra e adicione um atalho para recarregá-la:

```ini
exec-once = waybar
bind = SUPER SHIFT, R, exec, pkill waybar; waybar
```

## Módulos e interações

| Área | Módulos | Ação ao clicar |
| --- | --- | --- |
| Esquerda | espaços de trabalho e submapa do Hyprland | — |
| Centro | relógio e notificações | calendário; alternar Não Perturbe |
| Direita | CPU, GPU, memória, temperaturas, áudio, Wi-Fi, Bluetooth e energia | abrir controles correspondentes; energia abre o `wlogout` |

Os espaços de trabalho mostram `name` e `windows`: os nomes de aplicativos são
convertidos em ícones por `window-rewrite`, com `` como alternativa. Isso evita
depender da resolução de ícones GTK para manter uma indicação visual confiável.

O módulo Bluetooth mostra apenas ` on` e ` off`. A rede usa a primeira
interface que corresponda a `wl*`.

## Estrutura

```text
.
├── config.jsonc                     # Módulos, formatos e ações de clique
├── style.css                         # Paleta Catppuccin Mocha e layout
└── scripts/
    ├── cpu-temperature.sh            # Temperatura via lm_sensors
    ├── gpu-usage.sh                  # Utilização via nvidia-smi
    ├── gpu-temperature.sh            # Temperatura via nvidia-smi
    └── notifications.sh              # Estado do Não Perturbe no SwayNC
```

## Personalização

- **Cores e espaçamento:** edite `style.css`.
- **Ordem, formato e ações dos módulos:** edite `config.jsonc`.
- **Ícones por aplicativo:** adicione ou ajuste entradas em
  `hyprland/workspaces.window-rewrite` no `config.jsonc`.
- **Comandos dos cliques:** ajuste as chaves `on-click` para os aplicativos que
  você usa. Por exemplo, `nm-connection-editor` pode substituir o comando de
  rede em ambientes onde o GNOME Control Center não esteja instalado.

## Validação

Antes de recarregar a barra, valide a configuração e os scripts:

```sh
jq . ~/.config/waybar/config.jsonc
sh -n ~/.config/waybar/scripts/*.sh
```

Depois, dentro da sessão gráfica do Hyprland, recarregue a Waybar:

```sh
pkill waybar
waybar
```

## Exemplo visual

<img width="2555" height="33" alt="image" src="https://github.com/user-attachments/assets/40debb4b-dd31-42a8-a0f6-7e2dd03d4bf6" />



## Observações

- A aparência e os cliques devem ser verificados dentro de uma sessão gráfica
  do Hyprland; executá-los fora dela não valida a interface.
- Os scripts de GPU foram feitos para NVIDIA. Em máquinas sem NVIDIA, eles
  exibem `󰢮 --` e a barra continua funcional.
