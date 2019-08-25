(function() {
  var Q, last;

  Quintus.Util = function(Q) {
    Q.fadeIn = function(callback, rate) {
      if (rate == null) {
        rate = 10;
      }
      if (Q.fadeOpacity !== 0) {
        Q.fadeOpacity = Math.max(Q.fadeOpacity - 0.01, 0);
        clearTimeout(Q.fadeTimeoutId);
        return Q.fadeTimeoutId = setTimeout(function() {
          return Q.fadeIn(callback, rate);
        }, rate);
      } else {
        if (callback) {
          return callback.call();
        }
      }
    };
    Q.fadeOut = function(callback, rate) {
      if (rate == null) {
        rate = 10;
      }
      if (Q.fadeOpacity !== 1) {
        Q.fadeOpacity = Math.min(Q.fadeOpacity + 0.01, 1);
        clearTimeout(Q.fadeTimeoutId);
        return Q.fadeTimeoutId = setTimeout(function() {
          return Q.fadeOut(callback, rate);
        }, rate);
      } else {
        if (callback) {
          return callback.call();
        }
      }
    };
    Q.random = function(min, max) {
      return Math.random() * (max - min) + min;
    };
    Q.center = function() {
      return {
        x: Q.width / 2,
        y: Q.height / 2
      };
    };
    Q.insideViewport = function(entity) {
      return Q.insidePolygon([
        {
          x: Q.canvasToStageX(0, Q.stage()),
          y: Q.canvasToStageY(0, Q.stage())
        }, {
          x: Q.canvasToStageX(Q.width, Q.stage()),
          y: Q.canvasToStageY(0, Q.stage())
        }, {
          x: Q.canvasToStageX(Q.width, Q.stage()),
          y: Q.canvasToStageY(Q.height, Q.stage())
        }, {
          x: Q.canvasToStageX(0, Q.stage()),
          y: Q.canvasToStageY(Q.height, Q.stage())
        }
      ], entity.p);
    };
    return Q.insidePolygon = function(points, p) {
      var c, i, j, l;
      c = false;
      i = -1;
      l = points.length;
      j = l - 1;
      while (++i < l) {
        ((points[i].y <= p.y && p.y < points[j].y) || (points[j].y <= p.y && p.y < points[i].y)) && (p.x < (points[j].x - points[i].x) * (p.y - points[i].y) / (points[j].y - points[i].y) + points[i].x) && (c = !c);
        j = i;
      }
      return c;
    };
  };

  Quintus.Math = function(Q) {
    Q.random = function(from, to) {
      return Math.floor(Math.random() * (to - from + 1) + from);
    };
    Q.normalizeAngle = function(angle) {
      var result;
      result = angle % 360;
      while (true) {
        if (result > 0) {
          break;
        }
        result = result + 360;
      }
      return result;
    };
    Q.angle = function(fromX, fromY, toX, toY) {
      var distX, distY, radians;
      distX = toX - fromX;
      distY = toY - fromY;
      radians = Math.atan2(distY, distX);
      return Q.radiansToDegrees(radians) - 90;
    };
    Q.distance = function(fromX, fromY, toX, toY) {
      if (toX == null) {
        toX = 0;
      }
      if (toY == null) {
        toY = 0;
      }
      return Math.sqrt(Math.pow(fromX - toX, 2) + Math.pow(fromY - toY, 2));
    };
    Q.offsetX = function(angle, radius) {
      return Math.sin(angle / 180 * Math.PI) * radius;
    };
    Q.offsetY = function(angle, radius) {
      return -Math.cos(angle / 180 * Math.PI) * radius;
    };
    Q.degreesToRadians = function(degrees) {
      return degrees * (Math.PI / 180);
    };
    return Q.radiansToDegrees = function(radians) {
      return radians * (180 / Math.PI);
    };
  };

  Q = Quintus().include('Util, Math, Sprites, Scenes, Input, 2D, Touch, UI, Audio').setup({
    development: true,
    maximize: true
  }).controls().touch().enableSound();

  Q.gravityY = 0;

  Q.gravityX = 0;

  Q.clearColor = "#000";

  Q.input.keys[87] = 'up';

  Q.input.keys[65] = 'left';

  Q.input.keys[68] = 'right';

  Q.load(['ship1.png', 'ship2.png', 'ship3.png', 'particle.png', 'blasterShot.png', 'blasterShot.mp3', 'rocketShot.png', 'rocketShot.mp3', 'background.png', 'star.png', 'shieldFlare.png', 'hit.mp3', 'exp.mp3'], function() {
    return Q.stageScene('Menu');
  }, {
    progressCallback: function(loaded, total) {
      var percent_loaded;
      percent_loaded = Math.floor(loaded / total * 100);
      return document.getElementById('loading_progress').style.width = percent_loaded + '%';
    }
  });

  window.Q = Q;

  document.body.onmousedown = function(event) {
    return Q.inputs['mouse'] = true;
  };

  document.body.onmouseup = function(event) {
    return delete Q.inputs['mouse'];
  };

  last = {};

  document.body.onmousemove = function(event) {
    last.x = event.x;
    return last.y = event.y;
  };

  setInterval(function() {
    if (last.x && last.y) {
      if (Q.stage()) {
        Q.inputs['mouseX'] = Q.canvasToStageX(last.x, Q.stage());
        return Q.inputs['mouseY'] = Q.canvasToStageY(last.y, Q.stage());
      }
    }
  }, 50);

  Q.scene('Game', function(stage) {
    var insert, k, player, ref, setupLevel;
    Q.state.reset({
      level: 1
    });
    player = new Q.SmallShip({
      asset: "ship1.png",
      angle: Math.random() * 360,
      x: Q.center().x,
      y: Q.center().y
    });
    player.add("blaster");
    player.add("input");
    player.add("minimap");
    player.add("hud");
    stage.insert(new Q.Background({
      target: player
    }));
    for (k = 1, ref = Q.width * Q.height / 10000; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--) {
      stage.insert(new Q.Star({
        target: player
      }));
    }
    stage.insert(player);
    player.on('destroyed', function() {
      return setTimeout(function() {
        return Q.fadeOut(function() {
          Q.stageScene('Menu');
          return Q.fadeIn();
        });
      }, 3000);
    });
    insert = function(p) {
      var ship;
      ship = new Q.SmallShip(p);
      ship.add("aiHunter");
      ship.add("blaster");
      stage.insert(ship);
      return ship.on('destroyed', function() {
        var won;
        won = true;
        Q._each(Q("SmallShip").items, function(ship) {
          if (ship.p.hp > 0 && ship.p.asset !== player.p.asset) {
            return won = false;
          }
        });
        if (won) {
          return setTimeout(function() {
            return Q.fadeOut(function() {
              Q.state.inc("level", 1);
              setupLevel();
              return Q.fadeIn();
            });
          }, 3000);
        }
      });
    };
    setupLevel = function() {
      var m, n, radius, ref1, results, theta, x, y;
      if (Q.state.p.level === 1 || Q.state.p.level % 5 === 0) {
        insert({
          asset: player.p.asset,
          x: player.p.x + Q.random(-100, 100),
          y: player.p.y + Q.random(-100, 100)
        });
      }
      results = [];
      for (n = m = 1, ref1 = Q.state.p.level; 1 <= ref1 ? m <= ref1 : m >= ref1; n = 1 <= ref1 ? ++m : --m) {
        radius = 1000;
        theta = Math.PI * 2 / 6 * n;
        x = player.p.x + radius * Math.cos(theta);
        y = player.p.y + radius * Math.sin(theta);
        results.push(insert({
          asset: "ship" + (Q.random(2, 3)) + ".png",
          angle: Math.random() * 360,
          x: x,
          y: y
        }));
      }
      return results;
    };
    stage.insert(new Q.Level());
    stage.add('viewport');
    stage.follow(player, {
      x: true,
      y: true
    });
    stage.on("postrender", function(ctx) {
      Q.fadeOpacity = Q.fadeOpacity || 0;
      ctx.save();
      ctx.setTransform(1, 0, 0, 1, 0, 0);
      ctx.translate(0, 0);
      ctx.fillStyle = "rgba(0,0,0," + Q.fadeOpacity + ")";
      ctx.fillRect(0, 0, Q.width, Q.height);
      return ctx.restore();
    });
    return setupLevel();
  });

  Q.scene('Menu', function(stage) {
    var button, color, k, ref, x;
    color = 'white';
    x = Q.width * (3 / 4);
    stage.insert(new Q.Background({
      target: null
    }));
    for (k = 1, ref = Q.width * Q.height / 10000; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--) {
      stage.insert(new Q.MenuStar);
    }
    stage.insert(new Q.UI.Text({
      label: 'Nebula',
      x: x,
      y: Q.height / 4,
      color: color,
      family: 'ui',
      size: 56
    }));
    stage.insert(new Q.UI.Button({
      label: 'New Game',
      x: x,
      y: Q.height / 4 * 2,
      fontColor: color,
      font: '400 24px ui'
    }, function() {
      return Q.fadeOut(function() {
        Q.stageScene('Game');
        return Q.fadeIn();
      });
    }));
    if (!Q.touchDevice) {
      button = new Q.UI.Button({
        label: "Mouse Toggle",
        x: x,
        y: Q.height / 4 * 3,
        fontColor: color,
        font: '400 24px ui'
      }, function() {
        return Q.mouseEnabled = !Q.mouseEnabled;
      });
      Object.defineProperty(button.p, 'label', {
        get: function() {
          return (Q.mouseEnabled ? "Disable" : "Enable") + " Mouse";
        }
      });
      stage.insert(button);
    }
    return stage.on("postrender", function(ctx) {
      Q.fadeOpacity = Q.fadeOpacity || 0;
      ctx.save();
      ctx.setTransform(1, 0, 0, 1, 0, 0);
      ctx.translate(0, 0);
      ctx.fillStyle = "rgba(0,0,0," + Q.fadeOpacity + ")";
      ctx.fillRect(0, 0, Q.width, Q.height);
      return ctx.restore();
    });
  });

  Q.component('ttl', {
    added: function() {
      this.startedAt = this.now();
      return this.entity.on("step", this, "step");
    },
    step: function() {
      if (this.now() > this.startedAt + this.entity.p.ttl) {
        return this.entity.destroy();
      }
    },
    now: function() {
      return new Date().getTime();
    }
  });

  Q.component('damageable', {
    added: function() {
      this.entity.on("draw", this, "draw");
      return this.entity.on("sensor", this, "collision");
    },
    collision: function(otherEntity) {
      var damage;
      if (damage = otherEntity.p.damage) {
        this.entity.p.hp = this.entity.p.hp - damage;
        otherEntity.p.damage = 0;
        this.entity.trigger('damaged', otherEntity);
      }
      if (this.entity.p.hp <= 0) {
        return this.entity.destroy();
      }
    },
    draw: function(ctx) {
      var metrics, text;
      if (this.entity.p.hp && this.entity.p.maxHp) {
        ctx.save();
        ctx.beginPath();
        ctx.font = "400 14px ui";
        text = (Math.round(this.entity.p.hp / this.entity.p.maxHp * 100)) + "%";
        metrics = ctx.measureText(text);
        ctx.fillStyle = "#FFF";
        ctx.rotate(Q.degreesToRadians(-this.entity.p.angle));
        ctx.fillText(text, -metrics.width / 2, -50);
        return ctx.restore();
      }
    }
  });

  Q.component('input', {
    added: function() {
      return this.entity.on("step", this, "step");
    },
    step: function(dt) {
      var targetAngle;
      if (Q.mouseEnabled && Q.inputs['mouseX'] && Q.inputs['mouseY']) {
        targetAngle = Q.normalizeAngle(this.entity.p.angle - Q.angle(this.entity.p.x, this.entity.p.y, Q.inputs['mouseX'], Q.inputs['mouseY']));
        if (targetAngle > 180) {
          this.entity.trigger('left', dt);
        } else {
          this.entity.trigger('right', dt);
        }
        if (Q.inputs['mouse']) {
          this.entity.trigger('fire');
        }
      }
      if (Q.inputs['fire']) {
        this.entity.trigger('fire');
      }
      if (Q.inputs['up'] || Q.inputs['action']) {
        this.entity.trigger('up', dt);
      }
      if (Q.inputs['left']) {
        this.entity.trigger('left', dt);
      }
      if (Q.inputs['right']) {
        return this.entity.trigger('right', dt);
      }
    }
  });

  Q.component('hud', {
    added: function() {
      return this.entity.on("postdraw", this, "draw");
    },
    draw: function(ctx) {
      var _this;
      _this = this.entity;
      return Q("SmallShip").each(function() {
        var i;
        if (this !== _this) {
          if (!this.p.points) {
            Q._generatePoints(this);
          }
          ctx.save();
          this.matrix.setContextTransform(ctx);
          ctx.scale(2, 2);
          ctx.beginPath();
          ctx.lineWidth = 2;
          ctx.strokeStyle = this.p.asset === _this.p.asset ? "rgba(0,255,0,0.25)" : "rgba(255,0,0,0.25)";
          ctx.moveTo(this.p.points[0][0], this.p.points[0][1]);
          i = 0;
          while (i < this.p.points.length) {
            ctx.lineTo(this.p.points[i][0], this.p.points[i][1]);
            i++;
          }
          ctx.lineTo(this.p.points[0][0], this.p.points[0][1]);
          ctx.stroke();
          return ctx.restore();
        }
      });
    }
  });

  Q.component('aiHunter', {
    added: function() {
      return this.entity.on("step", this, "step");
    },
    step: function(dt) {
      var target, targetAngle, targetDistance;
      this.entity.trigger('up', dt);
      if (target = this.search()) {
        targetAngle = Q.normalizeAngle(this.entity.p.angle - Q.angle(this.entity.p.x, this.entity.p.y, target.p.x, target.p.y));
        if (targetAngle > 180) {
          this.entity.trigger('left', dt);
        } else {
          this.entity.trigger('right', dt);
        }
        targetDistance = Q.distance(this.entity.p.x, this.entity.p.y, target.p.x, target.p.y);
        if (targetAngle > 170 && targetAngle < 190 && targetDistance < 200) {
          return this.entity.trigger('fire');
        }
      }
    },
    search: function(option, best, _this) {
      if (option == null) {
        option = null;
      }
      if (best == null) {
        best = null;
      }
      if (_this == null) {
        _this = this.entity;
      }
      Q._each(Q("SmallShip").items, function(option) {
        option = {
          distance: Q.distance(_this.p.x, _this.p.y, option.p.x, option.p.y),
          asset: option.p.asset,
          object: option
        };
        if (option.object !== _this && option.asset !== _this.p.asset && (!best || best.distance > option.distance)) {
          return best = option;
        }
      });
      return best && best.object;
    }
  });

  Q.component('aiWander', {
    added: function() {
      return this.entity.on("step", this, "step");
    },
    step: function(dt) {
      var targetAngle;
      if (!this.target || 50 > Q.distance(this.entity.p.x, this.entity.p.y, this.target.p.x, this.target.p.y)) {
        this.target = {
          p: {
            x: Math.random() * 1000,
            y: Math.random() * 1000
          }
        };
      }
      targetAngle = this.entity.p.angle - Q.angle(this.entity.p.x, this.entity.p.y, this.target.p.x, this.target.p.y);
      if (targetAngle > 0) {
        this.entity.trigger('left', dt);
      } else {
        this.entity.trigger('right', dt);
      }
      return this.entity.trigger('up', dt);
    }
  });

  Q.Weapon = Q.component('weapon', {
    lastFired: 0,
    added: function() {
      return this.entity.on('fire', this, 'tryFire');
    },
    tryFire: function() {
      var now;
      now = new Date().getTime();
      if (now > this.lastFired + Q[this.className].coolDown) {
        this.fire();
        return this.lastFired = now;
      }
    }
  });

  Q.components['blaster'] = Q.Weapon.extend("Blaster", {
    fire: function() {
      var angle, velocity;
      velocity = Q[this.className].velocity;
      angle = this.entity.p.angle;
      this.entity.stage.insert(new Q.BlasterShot({
        x: this.entity.p.x + Q.offsetX(angle, Math.max(this.entity.p.w, this.entity.p.h) * 1.3),
        y: this.entity.p.y + Q.offsetY(angle, Math.max(this.entity.p.w, this.entity.p.h) * 1.3),
        vx: this.entity.p.vx + Q.offsetX(angle, velocity),
        vy: this.entity.p.vy + Q.offsetY(angle, velocity),
        angle: angle
      }));
      return Q.audio.play('blasterShot.mp3');
    }
  }, {
    coolDown: 200,
    velocity: 750
  });

  Q.component('minimap', {
    added: function() {
      return this.entity.on("draw", this, "draw");
    },
    draw: function(ctx, width, height) {
      var _this, centerX, centerY, maxX, maxY, metrics, scale, text;
      if (width == null) {
        width = 150;
      }
      if (height == null) {
        height = 150;
      }
      maxX = 0;
      maxY = 0;
      _this = this.entity;
      Q("SmallShip").each(function() {
        var diffX, diffY;
        diffX = Math.abs(_this.p.x - this.p.x);
        if (diffX > maxX) {
          maxX = diffX;
        }
        diffY = Math.abs(_this.p.y - this.p.y);
        if (diffY > maxY) {
          return maxY = diffY;
        }
      });
      scale = Math.min(0.1, Math.min(width / maxX, height / maxY) / 2.1);
      centerX = width / 2;
      centerY = height / 2;
      ctx.save();
      ctx.setTransform(1, 0, 0, 1, 0, 0);
      ctx.translate(0, 0);
      ctx.lineWidth = "2";
      ctx.beginPath();
      ctx.strokeStyle = "rgba(255,255,255,0.25)";
      ctx.fillStyle = "rgba(255,255,255,0.1)";
      ctx.rect(0, 0, width, height);
      ctx.fill();
      ctx.stroke();
      _this = this.entity;
      Q("SmallShip").each(function() {
        var x, y;
        if (this !== _this) {
          ctx.beginPath();
          ctx.strokeStyle = this.p.asset === _this.p.asset ? "#0F0" : "#F00";
          x = centerX - ((_this.p.x - this.p.x) * scale);
          y = centerY - ((_this.p.y - this.p.y) * scale);
          ctx.rect(x, y, 1, 1);
          return ctx.stroke();
        }
      });
      ctx.save();
      ctx.beginPath();
      ctx.font = "400 14px ui";
      text = "SCALE: x1/" + (Math.round(1 / scale));
      metrics = ctx.measureText(text);
      ctx.fillStyle = "rgba(255,255,255,0.5)";
      ctx.fillText(text, width / 2 - metrics.width / 2, height + 5);
      ctx.restore();
      ctx.beginPath();
      ctx.strokeStyle = "#00F";
      ctx.rect(centerX, centerY, 1, 1);
      ctx.stroke();
      return ctx.restore();
    }
  });

  Q.Sprite.extend('Ship', {
    init: function(p) {
      this._super(Q._extend({
        sensor: true,
        type: Q.SPRITE_FRIENDLY,
        z: 10,
        hp: 10,
        maxHp: 10,
        recharge: .1
      }, p));
      this.add('2d');
      this.add('damageable');
      this.on('up', this, 'up');
      this.on('left', this, 'left');
      this.on('right', this, 'right');
      return this.on('destroyed', this, 'destroyed');
    },
    step: function(dt) {
      if (this.p.recharge * dt + this.p.hp < this.p.maxHp) {
        return this.p.hp = this.p.hp + this.p.recharge * dt;
      }
    },
    up: function(dt) {
      var distance;
      this.p.vx += Q.offsetX(this.p.angle, Q[this.className].acceleration) * dt;
      this.p.vy += Q.offsetY(this.p.angle, Q[this.className].acceleration) * dt;
      if (Q.distance(this.p.vx, this.p.vy) > Q[this.className].maxVelocity) {
        distance = Q.distance(this.p.vx, this.p.vy);
        this.p.vx = this.p.vx / distance * Q[this.className].maxVelocity;
        this.p.vy = this.p.vy / distance * Q[this.className].maxVelocity;
      }
      if (Q._loopFrame % 2 === 0) {
        return this.stage.insert(new Q.Particle({
          x: this.p.x - Q.offsetX(this.p.angle, this.p.cx),
          y: this.p.y - Q.offsetY(this.p.angle, this.p.cy),
          vx: this.p.vx - Q.offsetX(this.p.angle, Math.max(this.p.vx * 0.2, 100)),
          vy: this.p.vy - Q.offsetY(this.p.angle, Math.max(this.p.vy * 0.2, 100))
        }));
      }
    },
    turn: function(dt, degree) {
      return this.p.angle += degree * dt;
    },
    right: function(dt) {
      return this.turn(dt, Q[this.className].rotation);
    },
    left: function(dt) {
      return this.turn(dt, -Q[this.className].rotation);
    },
    destroyed: function(dt) {
      var angle, k, m, n, o, results;
      Q.audio.play('exp.mp3');
      for (n = k = 1; k <= 30; n = ++k) {
        angle = this.p.angle + Math.random() * 270;
        this.stage.insert(new Q.Particle({
          color: '#111',
          x: this.p.x,
          y: this.p.y,
          vx: this.p.vx - Q.offsetX(angle, Math.random() * 50),
          vy: this.p.vy - Q.offsetY(angle, Math.random() * 50),
          scale: 1,
          sclaeRate: .02,
          opacityRate: -.01,
          radius: 16
        }));
      }
      for (n = m = 1; m <= 10; n = ++m) {
        angle = this.p.angle + Math.random() * 270;
        this.stage.insert(new Q.Particle({
          color: 'orange',
          x: this.p.x,
          y: this.p.y,
          vx: this.p.vx - Q.offsetX(angle, 10),
          vy: this.p.vy - Q.offsetY(angle, 10),
          scale: Math.max(Math.random(), 0.3),
          scale: 1,
          sclaeRate: .02,
          radius: 16
        }));
      }
      results = [];
      for (n = o = 1; o <= 10; n = ++o) {
        angle = this.p.angle + Math.random() * 270;
        results.push(this.stage.insert(new Q.Particle({
          color: 'white',
          x: this.p.x,
          y: this.p.y,
          vx: this.p.vx - Q.offsetX(angle, 200),
          vy: this.p.vy - Q.offsetY(angle, 200),
          scale: Math.max(Math.random(), 0.3),
          scaleRate: -.01,
          opacityRate: -.01
        })));
      }
      return results;
    }
  });

  Q.Sprite.extend('Shot', {
    init: function(p) {
      this._super(Q._extend({
        sensor: true,
        type: Q.SPRITE_ENEMY,
        collisionMask: Q.SPRITE_FRIENDLY,
        z: 5,
        ttl: 1000
      }, p));
      this.add('2d');
      return this.add('ttl');
    }
  });

  Q.Sprite.extend('ShieldFlare', {
    init: function(p) {
      this._super(Q._extend({
        asset: 'shieldFlare.png',
        type: Q.SPRITE_NONE,
        opacity: .5,
        opacityRate: -.03,
        z: 5,
        ttl: 200
      }, p));
      this.add('2d');
      return this.add('ttl');
    },
    step: function(dt) {
      if (this.p.opacity >= 0) {
        return this.p.opacity += this.p.opacityRate;
      } else {
        return this.destroy();
      }
    },
    draw: function(ctx) {
      ctx.globalCompositeOperation = 'lighter';
      return this._super(ctx);
    }
  });

  Q.Sprite.extend('Particle', {
    init: function(p) {
      this._super(Q._extend({
        asset: 'particle.png',
        type: Q.SPRITE_NONE,
        collisionMask: Q.SPRITE_NONE,
        z: 5,
        opacity: .5,
        opacityRate: -.03,
        scale: .5,
        scaleRate: -.03,
        color: "white",
        radius: 8
      }, p));
      return this.add('2d');
    },
    step: function(dt) {
      if (!Q.insideViewport(this)) {
        this.destroy();
      }
      this.p.vx *= 1 - dt;
      this.p.vy *= 1 - dt;
      if (this.p.opacity !== 0) {
        this.p.opacity = Math.max(this.p.opacity + this.p.opacityRate, 0);
      } else {
        this.destroy();
      }
      if (this.p.scale !== 0) {
        return this.p.scale = Math.max(this.p.scale + this.p.scaleRate, 0);
      } else {
        return this.destroy();
      }
    },
    draw: function(ctx) {
      ctx.save();
      ctx.globalCompositeOperation = 'lighter';
      ctx.fillStyle = this.p.color;
      ctx.beginPath();
      ctx.arc(0, 0, this.p.radius, 0, 2 * Math.PI);
      ctx.fill();
      return ctx.restore();
    }
  });

  Q.Sprite.extend('Particle', {
    init: function(p) {
      this._super(Q._extend({
        asset: 'particle.png',
        type: Q.SPRITE_NONE,
        collisionMask: Q.SPRITE_NONE,
        z: 5,
        opacity: .5,
        opacityRate: -.03,
        scale: .5,
        scaleRate: -.03,
        color: "white",
        radius: 8
      }, p));
      return this.add('2d');
    },
    step: function(dt) {
      if (!Q.insideViewport(this)) {
        this.destroy();
      }
      this.p.vx *= 1 - dt;
      this.p.vy *= 1 - dt;
      if (this.p.opacity !== 0) {
        this.p.opacity = Math.max(this.p.opacity + this.p.opacityRate, 0);
      } else {
        this.destroy();
      }
      if (this.p.scale !== 0) {
        return this.p.scale = Math.max(this.p.scale + this.p.scaleRate, 0);
      } else {
        return this.destroy();
      }
    },
    draw: function(ctx) {
      ctx.save();
      ctx.globalCompositeOperation = 'lighter';
      ctx.fillStyle = this.p.color;
      ctx.beginPath();
      ctx.arc(0, 0, this.p.radius, 0, 2 * Math.PI);
      ctx.fill();
      return ctx.restore();
    }
  });

  Q.Sprite.extend('Star', {
    init: function(p) {
      this._super(p, {
        target: p.target,
        x: Math.random() * Q.width,
        y: Math.random() * Q.height,
        asset: 'star.png',
        scale: Math.max(Math.random(), .3),
        type: Q.SPRITE_NONE
      });
      return this.add('2d');
    },
    step: function(dt) {
      this.p.vx = this.p.target.p.vx * (Math.pow(this.p.scale, 10) / -1);
      this.p.vy = this.p.target.p.vy * (Math.pow(this.p.scale, 10) / -1);
      if (Math.abs(this.p.x - this.p.target.p.x) > Q.width || Math.abs(this.p.y - this.p.target.p.y) > Q.height) {
        this.p.x = Q.stage().viewport.x + (Math.random() * Q.width);
        return this.p.y = Q.stage().viewport.y + (Math.random() * Q.height);
      }
    }
  });

  Q.Sprite.extend('MenuStar', {
    init: function(p) {
      return this._super(p, {
        x: Math.random() * Q.width,
        y: Math.random() * Q.height,
        scale: Math.max(Math.random(), .3),
        asset: 'star.png',
        type: Q.SPRITE_NONE
      });
    },
    step: function(dt) {
      if (this.p.y > Q.height) {
        this.p.y = 0;
        this.p.x = Math.random() * Q.width;
      }
      return this.p.y += dt * Math.pow(100, this.p.scale);
    }
  });

  Q.Shot.extend('BlasterShot', {
    init: function(p) {
      this._super(Q._extend({
        asset: 'blasterShot.png',
        damage: 1
      }, p));
      return this.on("sensor", function(otherEntity) {
        var k, n, ref;
        n = Q.random(1, 3);
        for (k = 1, ref = n; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--) {
          this.stage.insert(new Q.Particle({
            x: otherEntity.p.x,
            y: otherEntity.p.y,
            vx: Q.random(-50, 50),
            vy: Q.random(-50, 50)
          }));
        }
        Q.audio.play('hit.mp3');
        return this.destroy();
      });
    },
    draw: function(ctx) {
      ctx.save();
      ctx.globalCompositeOperation = 'lighter';
      this._super(ctx);
      return ctx.restore();
    }
  });

  Q.UI.Text.extend("Level", {
    init: function() {
      this._super({
        label: "Level 1"
      });
      return Q.state.on("change.level", this, "level");
    },
    draw: function(ctx) {
      var metrics;
      ctx.save();
      ctx.setTransform(1, 0, 0, 1, 0, 0);
      ctx.translate(0, 0);
      ctx.beginPath();
      ctx.font = "400 24px ui";
      metrics = ctx.measureText(this.p.label);
      ctx.fillStyle = "#FFF";
      ctx.fillText(this.p.label, (Q.width / 2) - (metrics.width / 2), 50);
      return ctx.restore();
    },
    level: function(level) {
      return this.p.label = "Level " + level;
    }
  });

  Q.Sprite.extend('Background', {
    init: function(p) {
      return this._super(p, {
        target: p.target,
        x: 0,
        y: 0,
        asset: 'background.png',
        type: Q.SPRITE_NONE
      });
    },
    drawOffset: 200,
    debugRender: function() {},
    draw: function(ctx) {
      var offsetX, offsetY;
      if (this.stage.viewport) {
        offsetX = this.stage.viewport.centerX - Q.width / 2;
        offsetY = this.stage.viewport.centerY - Q.height / 2;
      } else {
        offsetX = 0;
        offsetY = 0;
      }
      if (this.p.target) {
        offsetX += -this.p.target.p.vx / 10;
        offsetY += -this.p.target.p.vy / 10;
      }
      return ctx.drawImage(this.asset(), 0, 0, this.asset().width, this.asset().height, offsetX - this.drawOffset, offsetY - this.drawOffset, Q.width + this.drawOffset * 2, Q.height + this.drawOffset * 2);
    }
  });

  Q.Ship.extend('SmallShip', {
    init: function(p) {
      this._super(Q._extend({
        asset: "ship" + (Math.floor((Math.random() * 3) + 1)) + ".png"
      }, p));
      return this.on('damaged', function(otherEntity) {
        return this.stage.insert(new Q.ShieldFlare({
          x: this.p.x,
          y: this.p.y,
          vx: this.p.vx,
          vy: this.p.vy,
          angle: otherEntity.p.angle - 180
        }));
      });
    }
  }, {
    acceleration: 100,
    rotation: 150,
    maxVelocity: 250
  });

}).call(this);
