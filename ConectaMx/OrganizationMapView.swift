//
//  OrganizationMapView.swift
//  ConectaMx
//
//  Created by Danna Valencia on 02/10/23.
//


import SwiftUI
import MapKit

struct OrganizationMapView: View {
    
    // Mapa direción
    @Binding var calle: String
    @Binding var numero: String
    @Binding var colonia: String
    @Binding var cp: String
    @Binding var ciudad: String
    @Binding var estado: String
    @Binding var pais: String
    
    
    var fullAddress: String {
        "\(calle) \(numero), \(colonia), \(cp), \(ciudad), \(estado), \(pais)"
    }
    
    var body: some View {
        
        Spacer()
        Spacer()
        HStack{
            Image(systemName: "mappin.and.ellipse")
            Text("Configurar Mapa")
                .font(.title2)
                .bold()
                .foregroundColor(Color(hex: "3D3D4E"))
        }
        Spacer()
        
        // Campos de dirección
        VStack(alignment: .leading, spacing: 10){
            // Calle
            VStack{
                Text("Calle")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                TextField("Calle", text: $calle)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1))
            }
            // Número y colonia
            HStack{
                VStack{
                    Text("Número")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)

                    TextField("Número", text: $numero)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                VStack{
                    Text("Colonia")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    TextField("Colonia", text: $colonia)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
            }
            
            // CP y ciudad
            HStack{

                VStack{
                    Text("Código Postal")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)

                    TextField("Código Postal", text: $cp)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                VStack{
                    Text("Ciudad")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    TextField("Ciudad", text: $ciudad)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
            }
            
            // Estado y país
            HStack{

                VStack{
                    Text("Estado")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)

                    TextField("Estado", text: $estado)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                VStack{
                    Text("País")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)

                    TextField("País", text: $pais)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                
            }

        }
        .padding(.horizontal)

        OrgMapView(address: fullAddress)

    }
}

#Preview {
    OrganizationMapView(calle: .constant("Avenida Eugenio Garza Sada"), numero: .constant("2411"), colonia: .constant("Tecnologico"), cp: .constant("64700"), ciudad: .constant("Monterrey"), estado: .constant("N.L."), pais: .constant("Mexico"))
}

/*
 
 
 
 */
