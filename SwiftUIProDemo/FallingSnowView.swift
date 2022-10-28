//
//  FallingSnowView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 15/9/22.
//

import SwiftUI

class ParticleSnow {
    var x: Double
    var y: Double
    let xSpeed: Double
    let ySpeed: Double
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 2
    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}

class SnowParticleSystem {
    var particles = [ParticleSnow]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize) {
        let delta = date - lastUpdate
        lastUpdate = date
        
        for (index, particle) in particles.enumerated() {
            if particle.deathDate < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y += particle.ySpeed * delta
            }
        }
        
        let newParticle = ParticleSnow(
            x: .random(in: -32...size.width),
                                   
            y: -32,
            xSpeed: .random(in: -50...50),
            ySpeed: .random(in: 100...500)
        )
        particles.append(newParticle)
    }
}

struct FallingSnowView: View {
    @State private var particleSytem = SnowParticleSystem()
    var body: some View {
        LinearGradient(colors: [.red, .indigo], startPoint: .top,
                       endPoint: .bottom).mask {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate =
                    timeline.date.timeIntervalSinceReferenceDate
                    particleSytem.update(date: timelineDate, size: size)
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    ctx.drawLayer { ctx in
                        for particle in particleSytem.particles {
                            ctx.opacity = particle.deathDate - timelineDate
                            ctx.fill(Circle().path(in: CGRect(x: particle.x, y:
                                                                particle.y, width: 32, height: 32)), with: .color(.white))
                        }
                    }
                }
                
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

struct FallingSnowView_Previews: PreviewProvider {
    static var previews: some View {
        FallingSnowView()
    }
}
