# Sous Chef — Asistente de Cocina por Voz

> Tu compañero de cocina por voz. Te guía paso a paso mientras cocinas — con las manos ocupadas, la voz es la única interfaz.

**Hackathon Openbase 2026 · Lima, Perú**

## El Problema

En la cocina, tus manos están mojadas, tienes un cuchillo en una y la sartén en la otra. La pantalla no sirve. Sous Chef convierte a un agente de IA en un compañero de cocina real que:

- Guía paso a paso, esperando tu confirmación antes de avanzar
- Sustituye ingredientes en tiempo real ("No tengo ají limo" → "Ponle rocoto picadito")
- Pone timers con contexto y te avisa proactivamente cuando terminen
- Adapta la receta a tu nivel y a lo que tengas disponible
- Habla español peruano con sabor limeño

## Tesis

Cuando la voz es la interfaz, el agente deja de ser una receta estática y se convierte en un **sous chef real**: adapta, sustituye, recuerda, cronometra, y te pregunta.

## Stack

| Componente | Tecnología |
|---|---|
| Voice pipeline | LiveKit + AssemblyAI (multilingual) + Cartesia TTS |
| Agente | Claude Code via Openbase Dispatcher |
| Backend | Django API (puerto 7999) |
| Conectividad | Tailscale (iPhone ↔ Mac) |
| Timers proactivos | Openbase Routines + Announcer API |
| Idioma | Español latinoamericano (Perú) |

## Arquitectura

```
iPhone (micrófono) → LiveKit Room → STT (AssemblyAI multilingual)
  → Dispatcher (Claude Code + skill sous-chef) → TTS (Cartesia)
  → LiveKit Room → iPhone (audio)

Timers: routine cada 5s → timer.sh → announcer API → voz proactiva
```

Sous Chef es un **skill** (`~/.agents/skills/sous-chef/SKILL.md`) que se carga sobre el dispatcher existente de Openbase. No requiere nuevos servicios — reutiliza toda la infraestructura de voz.

## Setup

### Prerequisitos

- [Openbase Coder](https://github.com/openbase-community/openbase) instalado y corriendo
- iPhone conectado via Tailscale
- `openbase-coder doctor` — todos los checks pasando

### Instalación

```bash
# 1. El skill ya está instalado en
ls ~/.agents/skills/sous-chef/SKILL.md

# 2. Habilitar el timer de cocina
openbase-coder routines update sous-chef-timer --enable

# 3. Reiniciar con dispatcher fresco
openbase-coder restart --recreate-dispatcher
```

### Uso

Haz una llamada de voz desde tu iPhone o la consola web y di:

> "Quiero hacer un ceviche limeño"

## Demo (3-5 min)

1. **Intro** — La voz no es una feature, es la única interfaz en la cocina
2. **Arranque** — "Quiero hacer un ceviche" → el agente pregunta qué tienes
3. **Sustitución** — "No tengo ají limo" → sugiere rocoto
4. **Guía paso a paso** — Una instrucción a la vez, espera confirmación
5. **Timer proactivo** — "Déjalo 3 minutos, yo te aviso" → habla solo al terminar
6. **Reporte** — "Dame la receta como quedó" → genera la receta adaptada

## Archivos del proyecto

```
~/.agents/skills/sous-chef/SKILL.md          # Skill principal
~/.openbase/sous-chef/timer.sh               # Script de timers
~/.openbase/sous-chef/active-timers.json     # Estado de timers activos
instructions/VOICE_INSTRUCTIONS.md           # Instrucciones de voz (español)
instructions/DISPATCHER_INSTRUCTIONS.md      # Trigger del sous-chef
```

## Equipo

Hackathon Openbase 2026 — Lima, Perú
