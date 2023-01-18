#!/bin/ash

exec curl `
  ` -H "Image update detected on Host" `
  ` -H "Priority: default" `
  ` -H "Tags: package" `
  ` -d "$DIUN_ENTRY_IMAGE has new image" `
  ` "$NTFY_URL"

