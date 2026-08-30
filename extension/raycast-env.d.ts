/// <reference types="@raycast/api">

/* 🚧 🚧 🚧
 * This file is auto-generated from the extension's manifest.
 * Do not modify manually. Instead, update the `package.json` file.
 * 🚧 🚧 🚧 */

/* eslint-disable @typescript-eslint/ban-types */

type ExtensionPreferences = {
  /** DeepSeek API Key - Stored by Raycast as a password preference */
  "apiKey": string,
  /** Enable Web Search - Let DeepSeek search the web whenever current information is needed */
  "webSearch": boolean,
  /** Deep Reasoning - Off is faster; enable a level only when you want extra reasoning */
  "reasoningLevel": "none" | "low" | "medium" | "high" | "max",
  /** Maximum Output Tokens - Upper limit for a single answer */
  "maxOutputTokens": string,
  /** Answer Window - The floating window stays visible when you click another app */
  "resultWindow": "persistent" | "raycast"
}

/** Preferences accessible in all the extension's commands */
declare type Preferences = ExtensionPreferences

declare namespace Preferences {
  /** Preferences accessible in the `ask` command */
  export type Ask = ExtensionPreferences & {}
}

declare namespace Arguments {
  /** Arguments passed to the `ask` command */
  export type Ask = {}
}
