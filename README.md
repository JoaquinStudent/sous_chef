# Sous Chef — Asistente de Cocina por Voz

> Tu compañero de cocina por voz. Te guia paso a paso mientras cocinas — con las manos ocupadas, la voz es la unica interfaz.

**Hackathon Openbase 2026 · Lima, Peru**

## El Problema

En la cocina, tus manos estan mojadas, tienes un cuchillo en una y la sarten en la otra. No puedes tocar la pantalla. Sous Chef convierte a un agente de IA en un compañero de cocina real que:

- **Guia paso a paso** — una instruccion a la vez, espera tu confirmacion
- **Sustituye ingredientes** — "No tengo aji limo" → "Ponle rocoto picadito"
- **Cronometra proactivamente** — pone timers y te avisa cuando terminan
- **Adapta al nivel** — principiante o experto, ajusta el detalle
- **Habla español peruano** — con sabor limeño, como un compañero de verdad

## Tesis

Cuando la voz es la interfaz, el agente deja de ser una receta que lees y se convierte en un **sous chef real**: adapta, sustituye, recuerda, cronometra, y te pregunta.

## Como funciona

```
iPhone (microfono)
  → LiveKit Room
  → STT (AssemblyAI multilingual — entiende español)
  → Dispatcher + Skill Sous Chef (Claude Code)
  → TTS (Cartesia — habla español)
  → LiveKit Room
  → iPhone (audio)

Timers: routine cada 5s → timer.sh → announcer → voz proactiva
```

Sous Chef es un **skill** que se carga sobre el dispatcher de Openbase. Reutiliza toda la infraestructura de voz existente — sin nuevos servicios.

## Stack

| Componente | Tecnologia |
|---|---|
| Voz | LiveKit (WebRTC) |
| Transcripcion | AssemblyAI (multilingual) |
| Sintesis de voz | Cartesia TTS |
| Agente | Claude Code |
| Plataforma | Openbase Coder |
| Backend | Django API |
| Conectividad | Tailscale (iPhone ↔ Mac) |
| Timers | Openbase Routines + Announcer API |

## Setup

```bash
# Prerequisitos: Openbase Coder instalado y funcionando
# Verificar con:
openbase-coder doctor

# Habilitar el timer de cocina
openbase-coder routines update sous-chef-timer --enable

# Reiniciar con dispatcher fresco
openbase-coder restart --recreate-dispatcher
```

## Uso

Haz una llamada de voz desde tu iPhone o la consola web y di:

> "Quiero hacer un ceviche limeño"

## Demo

| Tiempo | Momento | Que demuestra |
|---|---|---|
| 0:00 | "Quiero hacer un ceviche" | Arranque conversacional |
| 0:30 | "No tengo aji limo" → sugiere rocoto | Sustitucion inteligente |
| 1:00 | "Corta el pescado en cubos" → "Listo" → siguiente paso | Guia paso a paso con confirmacion |
| 2:00 | "Dejalo 3 minutos, yo te aviso" | Timer proactivo |
| 3:00 | El agente habla solo: "¡Ya estan los 3 minutos!" | Agente proactivo — sin que preguntes |
| 3:30 | "Dame la receta como quedo" | Genera reporte con receta adaptada |

## Estructura del proyecto

```
sous-chef-skill/SKILL.md                   # Skill principal
timers/timer.sh                            # Script de timers proactivos
instructions/VOICE_INSTRUCTIONS.md         # Instrucciones de voz (español)
instructions/DISPATCHER_INSTRUCTIONS.md    # Trigger del skill
docs/index.html                            # Landing page / pitch
```

## Contribuidor

**Joaquin** · [@JoaquinStudent](https://github.com/JoaquinStudent)

---

Hackathon Openbase 2026 · Lima, Peru · La mejor gastronomia merece el mejor compañero.
