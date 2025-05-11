#!/bin/bash

while true; do
  ACTION=$(zenity --list --title="pactl Sink Yöneticisi" \
    --column="İşlem" "Yeni sink oluştur" "Sink sil" "Çık" --cancel-label="İptal")

  # Eğer kullanıcı "Cancel" butonuna basarsa, işlem sonlanacak
  if [[ $? -ne 0 ]]; then
    break
  fi

  if [[ "$ACTION" == "Yeni sink oluştur" ]]; then
    NAME=$(zenity --entry --title="Sink İsmi" --text="Sanal sink ismini gir (örneğin: Virtual1)")
    if [[ -n "$NAME" ]]; then
      pactl load-module module-null-sink sink_name="$NAME" sink_properties=device.description="$NAME"
      zenity --info --text="Yeni sink oluşturuldu: $NAME"
    fi

  elif [[ "$ACTION" == "Sink sil" ]]; then
    # Tüm sink'leri doğru şekilde listele
    SINKS=$(pactl list short sinks | awk '{print $2}')

    if [[ -z "$SINKS" ]]; then
      zenity --info --text="Hiç null-sink bulunamadı."
      continue  # Menüye geri dön
    fi

    # Sink adlarını listele
    CHOICE=$(echo "$SINKS" | zenity --list \
      --title="Silinecek Sink Seç" --column="Sink Adı")

    if [[ -n "$CHOICE" ]]; then
      # Seçilen sink'in ID'sini bul
      MODULE_ID=$(pactl list modules short | grep "sink_name=$CHOICE" | awk '{print $1}')
      
      if [[ -n "$MODULE_ID" ]]; then
        pactl unload-module "$MODULE_ID"
        zenity --info --text="Sink silindi: $CHOICE"
      else
        zenity --error --text="Bu sink'e bağlı modül bulunamadı."
      fi
    fi

  elif [[ "$ACTION" == "Çık" ]]; then
    break  # Script'i sonlandır
  fi
done
