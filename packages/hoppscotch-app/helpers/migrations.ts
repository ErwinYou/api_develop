import { settingsStore, applySetting } from "~/newstore/settings"

/*
 * This file contains all the migrations we have to perform overtime in various (persisted)
 * state/store entries
 */

export function performMigrations(): void {
  // Migrate old default proxy URL to the new proxy URL (if not set / overridden)
  if (settingsStore.value.PROXY_URL === "") {
    applySetting("PROXY_URL", "")
  }
}
