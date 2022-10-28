//
//  FirstParticleDrawingView.swift
//  SwiftUIProDemo
//
//  Created by Julio Rico on 15/9/22.
//

import SwiftUI

struct Particle {
    let position: CGPoint
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 1
}

class ParticleSystem {
    var particles = [Particle]()
    var position = CGPoint.zero
    
    func update(date: TimeInterval) {
        particles = particles.filter { $0.deathDate > date }
        particles.append(Particle(position: position))
    }
}

struct FirstParticleDrawingView: View {
    @State private var particleSystem = ParticleSystem()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                context.blendMode = .plusLighter
                context.addFilter(.blur(radius: 10))
                
                for particle in particleSystem.particles {
                    context.opacity = particle.deathDate - timelineDate
                    context.fill(Circle().path(in: CGRect(x: particle.position.x - 16, y: particle.position.y - 16, width: 32, height: 32)), with: .color(.cyan))
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ drag in
                    particleSystem.position = drag.location
                })
        )
        .ignoresSafeArea()
        .background(.black)
    }
}

struct FirstParticleDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstParticleDrawingView()
    }
}
