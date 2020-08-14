package com.ankamagames.dofus.kernel.sound.manager
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
    import com.ankamagames.dofus.datacenter.ambientSounds.PlaylistSound;
    import com.ankamagames.jerakine.BalanceManager.BalanceManager;
    import com.ankamagames.dofus.datacenter.playlists.Playlist;
    import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
    import com.ankamagames.tubul.interfaces.ISound;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
    import com.ankamagames.dofus.kernel.sound.type.SoundDofus;

    public class FightMusicManager 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightMusicManager));

        private var _fightMusics:Vector.<AmbientSound>;
        private var _bossMusics:Vector.<AmbientSound>;
        private var _fightMusic:PlaylistSound;
        private var _bossMusic:PlaylistSound;
        private var _hasBoss:Boolean;
        private var _fightMusicsId:Array;
        private var _fightMusicBalanceManager:BalanceManager;
        private var _fightMusicPlaylist:Playlist;
        private var _bossMusicPlaylist:Playlist;

        public function FightMusicManager()
        {
            this.init();
        }

        public function set hasBoss(boss:Boolean):void
        {
            this._hasBoss = boss;
        }

        public function prepareFightMusic():void
        {
            if (!RegConnectionManager.getInstance().isMain)
            {
                return;
            };
            RegConnectionManager.getInstance().send(ProtocolEnum.PREPARE_FIGHT_MUSIC);
        }

        public function startFightPlaylist(fadeStartVolume:Number=-1, fadeEndVolume:Number=1):void
        {
            if (!SoundManager.getInstance().manager.soundIsActivate)
            {
                return;
            };
            if (!RegConnectionManager.getInstance().isMain)
            {
                return;
            };
            var fightSongs:Array = new Array();
            var playlist:Playlist;
            if (((this._hasBoss) && (this._bossMusicPlaylist)))
            {
                fightSongs = this.createPlaylistSounds(this._bossMusicPlaylist);
                playlist = this._bossMusicPlaylist;
            }
            else
            {
                if (this._fightMusicPlaylist)
                {
                    fightSongs = this.createPlaylistSounds(this._fightMusicPlaylist);
                    playlist = this._fightMusicPlaylist;
                };
            };
            if (fightSongs.length > 0)
            {
                RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUNDS_PLAYLIST, playlist.crossfadeDuration, playlist.startRandom, playlist.startRandomOnce, playlist.random, fightSongs);
            };
        }

        public function stopFightMusic():void
        {
            if (!SoundManager.getInstance().manager.soundIsActivate)
            {
                return;
            };
            if (!RegConnectionManager.getInstance().isMain)
            {
                return;
            };
            RegConnectionManager.getInstance().send(ProtocolEnum.STOP_FIGHT_MUSIC);
        }

        public function setFightSounds(pFightMusic:Vector.<AmbientSound>, pBossMusic:Vector.<AmbientSound>, combatPlaylist:Playlist, bossFightPlaylist:Playlist):void
        {
            var asound:AmbientSound;
            this._fightMusics = pFightMusic;
            this._bossMusics = pBossMusic;
            this._fightMusicPlaylist = combatPlaylist;
            this._bossMusicPlaylist = bossFightPlaylist;
            var logText:String = "";
            if (((((this._fightMusics.length == 0) && (this._bossMusics.length == 0)) && ((!(this._fightMusicPlaylist)) || (this._fightMusicPlaylist.sounds.length == 0))) && ((!(this._bossMusicPlaylist)) || (this._bossMusicPlaylist.sounds.length == 0))))
            {
                logText = "Ni musique de combat, ni musique de boss ???";
            }
            else
            {
                logText = "Cette map contient les musiques de combat : ";
                for each (asound in this._fightMusics)
                {
                    logText = (logText + (asound.id + ", "));
                };
                logText = " et les musiques de boss d'id : ";
                for each (asound in this._bossMusics)
                {
                    logText = (logText + (asound.id + ", "));
                };
            };
            _log.info(logText);
        }

        public function selectValidSounds():void
        {
            var rnd:int;
            var playlistSound:PlaylistSound;
            var ambientSound:AmbientSound;
            var count:int;
            if (((this._fightMusicPlaylist) && (this._fightMusicPlaylist.sounds.length > 0)))
            {
                count = this._fightMusicPlaylist.sounds.length;
                rnd = int(int((Math.random() * count)));
                for each (playlistSound in this._fightMusicPlaylist.sounds)
                {
                    if (rnd == 0)
                    {
                        this._fightMusic = playlistSound;
                        break;
                    };
                    rnd--;
                };
            }
            else
            {
                for each (ambientSound in this._fightMusics)
                {
                    count++;
                };
                rnd = int(int((Math.random() * count)));
                for each (ambientSound in this._fightMusics)
                {
                    if (rnd == 0)
                    {
                        this._fightMusic = ambientSound;
                        break;
                    };
                    rnd--;
                };
            };
            if (((this._bossMusicPlaylist) && (this._bossMusicPlaylist.sounds.length > 0)))
            {
                count = this._bossMusicPlaylist.sounds.length;
                rnd = int(int((Math.random() * count)));
                for each (playlistSound in this._bossMusicPlaylist.sounds)
                {
                    if (rnd == 0)
                    {
                        this._bossMusic = playlistSound;
                        break;
                    };
                    rnd--;
                };
            }
            else
            {
                for each (ambientSound in this._bossMusics)
                {
                    count++;
                };
                rnd = int(int((Math.random() * count)));
                for each (ambientSound in this._bossMusics)
                {
                    if (rnd == 0)
                    {
                        this._bossMusic = ambientSound;
                        break;
                    };
                    rnd--;
                };
            };
        }

        private function init():void
        {
            this._fightMusicsId = TubulSoundConfiguration.fightMusicIds;
            this._fightMusicBalanceManager = new BalanceManager(this._fightMusicsId);
        }

        private function createPlaylistSounds(playlist:Playlist):Array
        {
            var playlistSound:PlaylistSound;
            var music:ISound;
            var soundUriM:Uri;
            var soundPathM:String;
            var iteration:int;
            var songsContainer:Array = new Array();
            for each (playlistSound in playlist.sounds)
            {
                soundPathM = SoundUtil.getConfigEntryByBusId(playlistSound.channel);
                soundUriM = new Uri(((soundPathM + playlistSound.id) + ".mp3"));
                music = new SoundDofus(String(playlistSound.id));
                iteration = playlist.iteration;
                if (iteration <= 0)
                {
                    iteration = 1;
                };
                music.setLoops(iteration);
                music.volume = (playlistSound.volume / 100);
                music.currentFadeVolume = 0;
                songsContainer.push(music.id);
            };
            return (songsContainer);
        }


    }
} com.ankamagames.dofus.kernel.sound.manager

