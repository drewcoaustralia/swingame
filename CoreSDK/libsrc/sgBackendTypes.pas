//=============================================================================
// sgBackendTypes.pas
//=============================================================================
//
// This provides the type details for records pointed to by abstract types
// from sgTypes.
//

unit sgBackendTypes;

interface
uses sgTypes;

  //
  // The kinds of ponters we manage
  //
  const
    AUDIO_PTR = 'AUDO'; // 4 type values
    NONE_PTR = 'NONE'; // done after clear


  type
    PointerIdentifier = array [0..3] of Char;

    //
    // SoundEffect -> SoundEffectData
    //
    SoundEffectData = packed record
      id: PointerIdentifier;
      effect: Pointer;
      filename, name: String;
    end;

  SoundEffectPtr = ^SoundEffectData;

  function ToSoundEffectPtr(s: SoundEffect): SoundEffectPtr;

implementation
uses sgShared;

  function ToSoundEffectPtr(s: SoundEffect): SoundEffectPtr;
  begin
    result := SoundEffectPtr(s);
    if Assigned(result) and (result^.id <> AUDIO_PTR) then
    begin
      RaiseWarning('Attempted to access a SoundEffect that appears to be an invalid pointer');
      result := nil;
    end;
  end;

end.
